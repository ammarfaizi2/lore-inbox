Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264122AbRFDG6C>; Mon, 4 Jun 2001 02:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264128AbRFDG5w>; Mon, 4 Jun 2001 02:57:52 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:46469 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264122AbRFDG5k>; Mon, 4 Jun 2001 02:57:40 -0400
From: "Chandrashekar Nagaraj" <chandrashekar.nag@wipro.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: How to redirect a task's o/p to different xterms ???
Date: Mon, 4 Jun 2001 12:19:57 +0530
Message-ID: <002601c0ecc2$9178d680$4433a8c0@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
	We r working on a ISP( Internet service provider ). We have a board
for the client side running on Vxworks and for the server we r using a 
simulator running on Linux. The simulator has a menu based interface,
and supports operations such as ftp,telnet,logging and so on.
	We have an option for multiple file copy. But when the copy is
going on, we get output for each copy operation. But since the o/p appears
on a single terminal, the o/p becomes crowdy. So, we are planning
to redirect the o/p of each copy operation a different xterm. Any help
in this regard will be very helpful...

Thankx in advance.

bye,
chandra.

