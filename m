Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283777AbRLITDL>; Sun, 9 Dec 2001 14:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283780AbRLITCv>; Sun, 9 Dec 2001 14:02:51 -0500
Received: from f95.law4.hotmail.com ([216.33.149.95]:55822 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S283777AbRLITCt>;
	Sun, 9 Dec 2001 14:02:49 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: marcelo@conectiva.com.br
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.4.17-pre6 at boot time
Date: Sun, 09 Dec 2001 19:02:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F95TljBOh8s4KWiGtXs0001a5a3@hotmail.com>
X-OriginalArrivalTime: 09 Dec 2001 19:02:43.0842 (UTC) FILETIME=[15204620:01C180E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Celeron 567 compiled for a i686 The previse kernel was 2.4.16 which 
worked correctly. These are my steps: downloaded the patch, patched kernel 
2.4.16 to 2.4.17-pre6 mv my config file out of the way so that i could do a 
make mrproper and a make clean then i moved my config file back and did a 
make menuconfig saved it and did a make bzImage &&  make modules && make 
modules_install I have a i810E grahpics board i810 Audio & Modem(Which 
doesn´t work) USB Hud, ACPI(which worked fine in 2.4.16) anything else I´ll 
be happy to give any other details.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

