Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTJaNNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTJaNNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:13:09 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:47597 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263281AbTJaNNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:13:05 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 vs sound
Date: Fri, 31 Oct 2003 08:13:02 -0500
User-Agent: KMail/1.5.1
References: <200310301008.27871.gene.heskett@verizon.net> <200310302049.45009.gene.heskett@verizon.net> <yw1xr80tzs0e.fsf@kth.se>
In-Reply-To: <yw1xr80tzs0e.fsf@kth.se>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200310310813.02970.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.58.154] at Fri, 31 Oct 2003 07:13:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 04:16, Måns Rullgård wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> Ok thanks, followup Q:  Whats the version number thats in the
>> kernel srcs?
>> The latest dl's available are version 9.8.
>
>No, it's 0.9.8.  The version in the kernel is approximately 0.9.7,
>with some patches, IIRC.

Well, I've got it (alsa) all compiled in without any luck.  But, I 
haven't deleted/commented out, any of the rather voluminous oss "shut 
this off and shut that off" lines in my modules.conf either.

Some of the tutorials in those links would seem to indicate that 
/etc/modules.conf has been renamed, which I have not, and my modutils 
are still the same as I've been using for a few months with 2.4.  I 
saw an announcement regarding a new modutils tool set last night, do 
I need to install that, and does that then fubar a 2.4.23-pre8 boot?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

