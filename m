Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283795AbRLITHb>; Sun, 9 Dec 2001 14:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283788AbRLITHW>; Sun, 9 Dec 2001 14:07:22 -0500
Received: from f76.law4.hotmail.com ([216.33.149.76]:13581 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S283782AbRLITHH>;
	Sun, 9 Dec 2001 14:07:07 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: PNP Bios 
Date: Sun, 09 Dec 2001 19:07:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F76FmWAFsTmIClmpcQA0001463a@hotmail.com>
X-OriginalArrivalTime: 09 Dec 2001 19:07:01.0972 (UTC) FILETIME=[AEFBC940:01C180E4]
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

