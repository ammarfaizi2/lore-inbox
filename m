Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbULRMsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbULRMsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 07:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbULRMsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 07:48:41 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:22666 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262247AbULRMsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 07:48:39 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1-V0.33-1
Date: Sat, 18 Dec 2004 07:48:37 -0500
User-Agent: KMail/1.7
References: <200412180708.17671.gene.heskett@verizon.net>
In-Reply-To: <200412180708.17671.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412180748.37296.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.47.244] at Sat, 18 Dec 2004 06:48:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 December 2004 07:08, Gene Heskett wrote:
>Greetings;
>
>I must report a couple of anomalies while running
>2.6.10-rc3-mm1-V0.33-1

CORRECTION!  2.6.10-rc3-mm1-V0.33-0, not 1!

>Twice now, odd goings on, such as lsof just locks itself till you
>give it a ctrl-c,  Only a reboot fixes this.
>
>And I assume its related, but NDI where, amanda's amandad gets stuck
>and this machine was not backed up this morning.  The
>/tmp/amanda-dbug/* files do not seem to offer any clues as to why,
>other than an occasional timeout.  The other client machine on this
>network, my firewall, was backed up normally, but nothing here made
>it to tape.  This occured once before on a previous version, 32-19 I
>think but won't swear to, and I believe if I reboot right now, and
>restart amdump, that it will work, so something would appear to be
>uptime sensitive.
>
>kmail has repeatedly lost its connection to outgoing.verizon.net,
> but a restart of kmail seems to restore that (if its not verizons
> fault, they *were* playing with it earlier today).  But this has
> been an ongoing problem.
>
>I'll go get the latest and install it for effects.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

