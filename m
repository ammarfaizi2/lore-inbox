Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286345AbRLTTQj>; Thu, 20 Dec 2001 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbRLTTQa>; Thu, 20 Dec 2001 14:16:30 -0500
Received: from pc3-stoc4-0-cust138.mid.cable.ntl.com ([213.107.175.138]:12037
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S286339AbRLTTQV>; Thu, 20 Dec 2001 14:16:21 -0500
From: "Ian Chilton" <ian@ichilton.co.uk>
To: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 wont do nfs root on Javastation
Date: Thu, 20 Dec 2001 19:16:01 -0000
Message-ID: <000001c1898a$c32e7b20$0a01a8c0@dipsy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I now have a much better fix for the "Javastation wont boot new 2.4
kernels" problem which requires no modification to the kernel but rather
to PROLL.

I have made the following files available at:
http://www.sparclinux.co.uk/files/javastation/proll/

proll_14.tar.gz - The normal PROLL straight from Pete's site
proll-14-nfsroot.diff - My patch to allow nfsroot with the newer kernels
proll.mrcoffee.ID14-nfsroot.gz - A mrcoffee binary - UNTESTED!
proll.krups.ID14-nfsroot.gz - A krups binary

(I don't have a MrCoffee so can't test this one).

I think Pete is going to release ID15 with the patch already applied.


My Krups kernel is also at:
http://www.sparclinux.co.uk/files/javastation/kernel/


Bye for Now,

Ian


