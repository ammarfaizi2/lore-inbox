Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTFLT5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTFLT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:57:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65018 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264974AbTFLT5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:57:22 -0400
Date: Thu, 12 Jun 2003 16:11:07 -0400
From: Bill Nottingham <notting@redhat.com>
To: Anders Karlsson <anders@trudheim.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
Message-ID: <20030612161107.C13241@devserv.devel.redhat.com>
Mail-Followup-To: Anders Karlsson <anders@trudheim.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1055371846.4071.52.camel@localhost.localdomain> <1055406614.2551.6.camel@tor.trudheim.com> <20030612144521.A19228@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030612144521.A19228@devserv.devel.redhat.com>; from notting@redhat.com on Thu, Jun 12, 2003 at 02:45:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham (notting@redhat.com) said: 
> Anders Karlsson (anders@trudheim.com) said: 
> > On Wed, 2003-06-11 at 23:50, Jeremy Fitzhardinge wrote:
> > > This is the latest version of my Enhanced SpeedStep driver for cpufreq. 
> > > It supports current Pentium M CPUs.
> > 
> > Can this be rebased against 2.4.21 and be included in 2.4.22-pre please?
> > :-)
> 
> http://people.redhat.com/notting/cpufreq-centrino.patch
> 
> Rebased against something vaguely 2.4.21-pre-ish.

... which happens to have updated cpufreq already in it, and
therefore requires it. Oops.

http://people.redhat.com/notting/linux-2.4.20-cpufreq.patch

Bill
