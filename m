Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVCFHxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVCFHxj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 02:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVCFHxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 02:53:39 -0500
Received: from main.gmane.org ([80.91.229.2]:6869 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261329AbVCFHxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 02:53:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@voxel.net>
Subject: Re: RFD: Kernel release numbering
Date: Sun, 06 Mar 2005 02:53:26 -0500
Message-ID: <pan.2005.03.06.07.53.24.672203@voxel.net>
References: <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <20050303170759.GA17742@ti64.telemetry-investments.com> <20050303193358.GA29371@redhat.com> <20050303203808.GA10408@ti64.telemetry-investments.com> <42278194.7020409@pobox.com> <20050303221503.GS4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-194-62-26.nycap.res.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2005 23:15:03 +0100, Adrian Bunk wrote:

> On Thu, Mar 03, 2005 at 04:28:52PM -0500, Jeff Garzik wrote:
>> Bill Rugolsky Jr. wrote:
>> >I've watched you periodically announce "hey, I'm doing an update for
>> >FC3/FC2, please test" on the mail list, and a handful of people go test.
>> >If we could convince many of the the less risk-averse but lazy users to
>> >grab kernels automatically from updates/3/testing/ or updates/3/unstable/
>> >as part of "yum update", and have a way to manage the plethora of (even
>> >daily) kernel updates by removing old unused kernels, then we'd only
>> >have to convince them *once* to set up their YUM repos, and then get them
>> >to poweroff or reboot [or use a Xen domain] occasionally. :-)
>> 
>> 
>> Tangent:  I would like to see requests-for-testing for FC kernels on LKML.
>> 
>> If people announce -ac/-as/-aa/-ck/etc. kernels on LKML, why not distro 
>> kernels?
> 
> Debian unstable currently contains only for kernel 2.6.8 (which is AFAIK 
> still the main kernel in Debian unstable although there are also 2.6.10 
> sources and 2.6.10 kernel images on some architectures) for eight 
> different architectures - many of them containing or depending on their 
> own patches.
> 

There's also no other (suitable) place to announce kernel trees.  Debian
kernels get announced on various debian-related lists; I'd imagine FC
kernels have the same thing.  The only place to announce non-distro trees
is lkml (and I've had requests for an -as specific announce list, I
haven't haven't found the time to get something going).



