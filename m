Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSALNAR>; Sat, 12 Jan 2002 08:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSALNAI>; Sat, 12 Jan 2002 08:00:08 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:5394 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S286188AbSALM7y>; Sat, 12 Jan 2002 07:59:54 -0500
Message-ID: <000a01c19b69$c5c778a0$d65a64d3@homep4>
From: "Zeng Yu" <zengyu1234567@yahoo.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: setting up proxy arp with subnetting in 2.4?
Date: Sat, 12 Jan 2002 21:05:10 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.4, when an interface's proxy-arp is enabled, kernel will automatically
answer on it to arp requests for networks on other interfaces. In some cases
this auto-arp feature is not appropriate. Is there any method to set the arp
proxy entries(with subnetting) manually as in 2.2?

ZengYu





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

