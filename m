Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271969AbTHKFJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272052AbTHKFJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:09:23 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:3476 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271969AbTHKFJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:09:22 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: <gene.heskett@verizon.net>,
       "'Gerardo Exequiel Pozzi'" <vmlinuz386@yahoo.com.ar>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Modules fail to build / install in 2.6.0-test3
Date: Mon, 11 Aug 2003 00:08:37 -0500
Message-ID: <002f01c35fc6$a00150f0$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <200308102322.04017.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah! Guilty as charged. I shall do that first thing tomorrow (today?)
morning.

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------

-----Original Message-----
From: Gene Heskett [mailto:gene.heskett@verizon.net]
Sent: Sunday, August 10, 2003 10:22 PM
To: vlad@lrsehosting.com; 'Gerardo Exequiel Pozzi'
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules fail to build / install in 2.6.0-test3


On Sunday 10 August 2003 22:39, vlad@lrsehosting.com wrote:
>However, after a successful build, and installation of
>module-init-tools-0.9.13-pre2.tar.bz2, I get the same errors from
> test3. Kernel builds (and is running) fine, it's just the modules
> in the last error message that refuse to build.

The lack of reading the README etc in that archive busted me, and I
think I ripped it all out and put it back in 3 times before I finally
got all the linkages correct.

--
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.



