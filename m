Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284367AbRLCIvu>; Mon, 3 Dec 2001 03:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284369AbRLCItk>; Mon, 3 Dec 2001 03:49:40 -0500
Received: from [165.139.124.200] ([165.139.124.200]:22736 "EHLO
	xinul2.hobart.k12.in.us") by vger.kernel.org with ESMTP
	id <S284338AbRLBWiW>; Sun, 2 Dec 2001 17:38:22 -0500
From: "Russell Mellon" <mellonr@hobart.k12.in.us>
To: <linux-kernel@vger.kernel.org>
Subject: IP address 10.1.1.0/16 not valid
Date: Sun, 2 Dec 2001 16:39:37 -0600
Message-ID: <PDEDJCHJOFMEOMMKOPDGOECJCLAA.mellonr@hobart.k12.in.us>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is it that the kernel seems to reject using the address 10.1.1.0 on a
255.255.0.0 netmask.  That address isn't the broadcast address, 10.1.0.0 is.

-Russ

SHIFT TO THE LEFT! SHIFT TO THE RIGHT! POP UP, PUSH DOWN, BYTE, BYTE, BYTE!

SHL! SHR! POP AX! PUSH AX! DB! DB! DB!


