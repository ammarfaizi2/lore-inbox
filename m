Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSGKNRb>; Thu, 11 Jul 2002 09:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317835AbSGKNRa>; Thu, 11 Jul 2002 09:17:30 -0400
Received: from [203.124.139.197] ([203.124.139.197]:31492 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP
	id <S317834AbSGKNRa>; Thu, 11 Jul 2002 09:17:30 -0400
From: "Sujit" <sujit.menon@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Urgent Information
Date: Mon, 11 Mar 2002 19:24:39 +0530
Message-ID: <000001c1c904$4a188e60$f209a8c0@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

While making enhancements to the 3com driver(vortex) I stumbled upon a grey
stone regarding the ioctl calls. can there be more than 16 ioctl calls for
the device ? The question arose from the fact that whenever a new ioctl
command is issued the kernel by default returns one of the Private ioctl
command. Hence would like to know more regarding these.

Please CC me the answer personnally.

Thanks & Regards
Sujit Menon

