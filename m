Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130804AbQLCPx5>; Sun, 3 Dec 2000 10:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbQLCPxr>; Sun, 3 Dec 2000 10:53:47 -0500
Received: from post.5ci.lt ([212.122.64.16]:27922 "HELO post.5ci.lt")
	by vger.kernel.org with SMTP id <S130804AbQLCPx0>;
	Sun, 3 Dec 2000 10:53:26 -0500
Reply-To: <vytask@5ci.lt>
From: "Vytautas Kasparavicius" <vytask@5ci.lt>
To: <linux-kernel@vger.kernel.org>
Subject: HP E60 strange network problems
Date: Sun, 3 Dec 2000 17:22:45 +0200
Message-ID: <000001c05d3c$e433e100$020a0a0a@transvesta.lt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-4"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Have strange problem:
HP E60 server(Intel 82559 onboard NIC) + RedHat 6.2 with latest fixes. About
40 computers(WIN9X) in local network, 3COM dual speed switch and 3 compex
10Mb hubs. Everything is OK except sometimes can't ping workstations from
linux server. From workstations I can ping everything without any problems,
but from linux server sometimes can't ping another computers on network.
Here is no "request timed out" errors, just ping freezes. No error entries
in /var/log/messages. Boot log without problems too. Someone expierenced
similiar problems ????
Tried to replace switch with 10Mb hub, to move server on another port, all
cabling is UTP5(tested) nothing helps
Please answer to email, because I'm not subscribed to this list.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
