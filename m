Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbRG1Qvf>; Sat, 28 Jul 2001 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRG1Qv0>; Sat, 28 Jul 2001 12:51:26 -0400
Received: from pop.gmx.net ([194.221.183.20]:50008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267000AbRG1QvP>;
	Sat, 28 Jul 2001 12:51:15 -0400
Message-ID: <0dee01c11785$3a874f80$0301a8c0@none56n4x0fcnq>
From: "Thomas Kotzian" <thomasko321k@gmx.at>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E15Q8Uz-0005l0-00@the-village.bc.nu> <01072902183404.02683@kiwiunixman.nodomain.nowhere>
Subject: missing symbols in 2.4.7-ac2
Date: Sat, 28 Jul 2001 18:43:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

when compiling with highmem = 4GB
problem in 3c59x - module:
unresolved symbol nr_free_highpages ...

ThomasK.

