Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136146AbREGOj2>; Mon, 7 May 2001 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136145AbREGOjS>; Mon, 7 May 2001 10:39:18 -0400
Received: from atlante.atlas-iap.es ([194.224.1.3]:57359 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S136136AbREGOjB>; Mon, 7 May 2001 10:39:01 -0400
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: RE: what causes Machine Check exception? revisited (2.2.18)
Date: Mon, 7 May 2001 16:38:58 +0200
Message-ID: <LOEGIBFACGNBNCDJMJMOAEDCCIAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Definitely not caused by:
>> Bad Rams, mb-chipset.
>
> Erm, it was bad RAM everytime it happened to me. On standard PCs, you
> don't see those because you don't have ECC and the error is simply not
> detected.

I did have the same problem with an SMP Intel 440LX which run without any
problem since 1998. When I installed 2.2.18 it could run for more than 5
minutes (Alan suggested me it was .

I am not sure it's a RAM poblem, because it never gave/gives a SEGFAULT
compiling the kernel. I brought it back to 2.2.16 and it's running happy.

Could be some SMP/BIOS related problem? If it's the RAM or chipset, I am
scared how we could use it for three years and suddenly it hangs with a new
version of the kernel... Blame to Intel?


--ricardo
http://m3d.uib.es/~gallir/

