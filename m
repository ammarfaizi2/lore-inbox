Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTFMA3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 20:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTFMA3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 20:29:55 -0400
Received: from main.gmane.org ([80.91.224.249]:183 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265082AbTFMA3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 20:29:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
Date: Thu, 12 Jun 2003 19:42:49 -0500
Organization: Complete.Org
Message-ID: <877k7qq03a.fsf@complete.org>
References: <1055371846.4071.52.camel@localhost.localdomain> <1055406614.2551.6.camel@tor.trudheim.com>
 <20030612144521.A19228@devserv.devel.redhat.com>
 <20030612161107.C13241@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:mVAu0Q1KB0B43nWrDWndhq5LFsk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham <notting@redhat.com> writes:

>> > Can this be rebased against 2.4.21 and be included in 2.4.22-pre please?
>> > :-)
>> 
>> http://people.redhat.com/notting/cpufreq-centrino.patch
>> 
>> Rebased against something vaguely 2.4.21-pre-ish.
>
> ... which happens to have updated cpufreq already in it, and
> therefore requires it. Oops.

Umm, no it doesn't.  Perhaps you're using an ac kernel?

I'd be happy to test this against vanilla 2.4.21-rc8, but it has no
cpufreq at all, so neither of these patches are going to work.

-- John

>
> http://people.redhat.com/notting/linux-2.4.20-cpufreq.patch
>
> Bill

