Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130584AbQLTX64>; Wed, 20 Dec 2000 18:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130756AbQLTX6q>; Wed, 20 Dec 2000 18:58:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39434 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130584AbQLTX6f>;
	Wed, 20 Dec 2000 18:58:35 -0500
Message-ID: <006401c06adc$5c6a65c0$87dde23e@enode>
From: "Jens Müller"  <jens@unfaehig.de>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3A412C8D.59DDD9F2@BitWagon.com> <Pine.NEB.4.31.0012202338040.21463-100000@pluto.fachschaften.tu-muenchen.de> <20001221002240.A1213@var.cx>
Subject: Re: tighter compression for x86 kernels
Date: Thu, 21 Dec 2000 00:27:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: jens@unfaehig.de
X-MDRcpt-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Frank v Waveren" <fvw@var.cx>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: "John Reiser" <jreiser@BitWagon.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, December 21, 2000 12:22 AM
Subject: Re: tighter compression for x86 kernels


> Seems GPL2 to me. I haven't read all of the rest of the page, but
> that'd either be dual licensing stuff, or further restrictions, which
> would be in contradiction with the GPL.
>
Seems to be kind of dual licensing:

"The stub which is imbedded in each UPX compressed program is part
   of UPX and UCL, and contains code that is under our copyright. The
   terms of the GNU General Public License still apply as compressing
   a program is a special form of linking with our stub.

   As a special exception we grant the free usage of UPX for all
   executables, including commercial programs.
   See below for details and restrictions."

It extends the scope of the license to _linking_ with commercial
software.

Jens




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
