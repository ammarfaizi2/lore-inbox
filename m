Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTKFRnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTKFRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:43:49 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:12518 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263784AbTKFRnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:43:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Valdis.Kletnieks@vt.edu, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: load 2.4.x binary only module on 2.6
Date: Thu, 6 Nov 2003 12:43:19 -0500
User-Agent: KMail/1.5.1
Cc: Marcel Lanz <marcel.lanz@ds9.ch>, linux-kernel@vger.kernel.org
References: <20031106153004.GA30008@ds9.ch> <20031106155815.GQ7665@parcelfarce.linux.theplanet.co.uk> <200311061606.hA6G6Jf4026228@turing-police.cc.vt.edu>
In-Reply-To: <200311061606.hA6G6Jf4026228@turing-police.cc.vt.edu>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061243.19536.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.62.77] at Thu, 6 Nov 2003 11:43:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 11:06, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 06 Nov 2003 15:58:15 GMT, 
viro@parcelfarce.linux.theplanet.co.uk said:
>> On Thu, Nov 06, 2003 at 04:30:04PM +0100, Marcel Lanz wrote:
>> > I have a binary only module for 2.4.x.
>> > How much work is it to write a kind of wrapper to load an "old"
>> > module on 2.6 ?
>>
>> Unfeasible.
>
>http://www.minion.de for a counter-example.  Of course, the NVidia
>driver was already built with a wrapper for the 2.4 kernel, so doing
> a 2.6 version wasn't too bad.
>
It may be there, and I may have a copy of it, but it won't install if 
I'm running 2.6.0-test9-mm2.

>It's really going to depend on which kernel interfaces the module
> actually uses, and what the module is doing.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

