Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRGQLvB>; Tue, 17 Jul 2001 07:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266152AbRGQLuz>; Tue, 17 Jul 2001 07:50:55 -0400
Received: from oe17.law3.hotmail.com ([209.185.240.121]:3598 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266150AbRGQLt5>;
	Tue, 17 Jul 2001 07:49:57 -0400
X-Originating-IP: [64.108.12.20]
Reply-To: "William Scott Lockwood III" <scottlockwood@hotmail.com>
From: "William Scott Lockwood III" <thatlinuxguy@hotmail.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107171532450.1817-100000@ketil.np>
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
Date: Tue, 17 Jul 2001 06:51:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE17UirmJJgWha8vFnq000074b6@hotmail.com>
X-OriginalArrivalTime: 17 Jul 2001 11:49:55.0972 (UTC) FILETIME=[992C0440:01C10EB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id VAA22744

It never ceases to amaze me how ANAL some people on this list are.  :-)

----- Original Message ----- 
From: "Ketil Froyn" <ketil@froyn.com>
To: "David Balazic" <david.balazic@uni-mb.si>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 17, 2001 8:35 AM
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo


| On Tue, 17 Jul 2001, David Balazic wrote:
| 
| > /proc/cpuinfo gives :
| > cache size: 64 KB
| >
| > This is wrong :
| >  - the Duron has 192 kilobytes of cache ( 64 L1 I, 64 L1 D , 64 L2 unified )
| >  - what is KB ?
| >    - "kilo" is abbreviated to 'k' , not 'K'
| >    - "B" means "Bell" :-)
| 
| I believe it is normal to write 'K' for 1024, 'k' for 1000 and 'B' for
| bytes and 'b' for bits.
| 
| Have a look at acronymfinder.com, they distinguish the capital and
| lowercase b for bits and bytes.
| 
| Ketil
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
