Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRLFR7y>; Thu, 6 Dec 2001 12:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRLFR7f>; Thu, 6 Dec 2001 12:59:35 -0500
Received: from ns1.jasper.com ([64.19.21.34]:2996 "EHLO ersfirep1")
	by vger.kernel.org with ESMTP id <S281754AbRLFR7d>;
	Thu, 6 Dec 2001 12:59:33 -0500
From: "Radivoje Todorovic" <radivojet@jaspur.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Need guide
Date: Thu, 6 Dec 2001 11:56:29 -0600
Message-ID: <BOEOJGNGENIJJMAOLHHCOEBECLAA.radivojet@jaspur.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Maybe not for this list but I would appreciate any help

I have two Linux 2.4.10 boxes on the same subnet 10.0.0.0/255.255.255.0

1) 10.0.0.1
2) 10.0.0.2

My goal is to run PPPoE so the client is 10.0.0.1 and server is 10.0.0.2. On
both hosts kernel is compiled with experimental pppoe support. I have
dowloaded pppd and run into configuration problems. As I am an absolute
beginner it would not make much sense to list the problems here. If someone
tried the same scenario as I am trying I would appreciate any help

So

How exactly to setup pppd to use pppoe kernel module (all pppxxx modules I
did insmod)?


Cheers!
Rade

