Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTFMBHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTFMBHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:07:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19658 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265089AbTFMBGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:06:01 -0400
Date: Thu, 12 Jun 2003 21:19:44 -0400
From: Bill Nottingham <notting@redhat.com>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
Message-ID: <20030612211944.C25224@devserv.devel.redhat.com>
Mail-Followup-To: John Goerzen <jgoerzen@complete.org>,
	linux-kernel@vger.kernel.org
References: <1055371846.4071.52.camel@localhost.localdomain> <1055406614.2551.6.camel@tor.trudheim.com> <20030612144521.A19228@devserv.devel.redhat.com> <20030612161107.C13241@devserv.devel.redhat.com> <877k7qq03a.fsf@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <877k7qq03a.fsf@complete.org>; from jgoerzen@complete.org on Thu, Jun 12, 2003 at 07:42:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Goerzen (jgoerzen@complete.org) said: 
> Bill Nottingham <notting@redhat.com> writes:
> 
> >> > Can this be rebased against 2.4.21 and be included in 2.4.22-pre please?
> >> > :-)
> >> 
> >> http://people.redhat.com/notting/cpufreq-centrino.patch
> >> 
> >> Rebased against something vaguely 2.4.21-pre-ish.
> >
> > ... which happens to have updated cpufreq already in it, and
> > therefore requires it. Oops.
> 
> Umm, no it doesn't.  Perhaps you're using an ac kernel?

Yeah, way too many patch dependencies. 2.4.21-pre-ac, +
the below patch, and then the centrino patch.

> > http://people.redhat.com/notting/linux-2.4.20-cpufreq.patch

Apologies for the confusion.

Bill
