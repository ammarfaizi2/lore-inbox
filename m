Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRFLRYW>; Tue, 12 Jun 2001 13:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbRFLRYM>; Tue, 12 Jun 2001 13:24:12 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:56495 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S261881AbRFLRX4>; Tue, 12 Jun 2001 13:23:56 -0400
Date: Tue, 12 Jun 2001 17:05:33 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200106121705.f5CH5X028029@cyrix.stev.org>
To: p.caci@seabone.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: es1371 and recent kernels
In-Reply-To: <873d95lnqr.fsf@paperino.int-seabone.net>
In-Reply-To: <873d95lnqr.fsf@paperino.int-seabone.net>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

yes i can

Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
   IRQ 12.
   Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
   I/O at 0xe800 [0xe83f].

           CPU0       
  0:   17921979          XT-PIC  timer
  1:      82047          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:         10          XT-PIC  
  8:          1          XT-PIC  rtc
 10:   17414341          XT-PIC  eth0
 12:   12959553          XT-PIC  es1371
 14:    3066619          XT-PIC  ide0
 15:         16          XT-PIC  ide1

e800-e83f : Ensoniq ES1371 [AudioPCI-97]
  e800-e83f : es1371


no problems with it at all
though it is the same card as yours

thats on a 2.4.5 kernel

>
>[please be kind and Cc when replying]
>
>Has someone been able to get es1371 to actually produce anything
>audible with latest kernels? The last version I could use was 2.4.0.
>Then I had some trouble but I attributed them to devfs. Now I've


-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  5:00pm  up 2 days,  1:42,  3 users,  load average: 0.00, 0.00, 0.00
