Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280207AbRJaNVh>; Wed, 31 Oct 2001 08:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280197AbRJaNV1>; Wed, 31 Oct 2001 08:21:27 -0500
Received: from mail024.mail.bellsouth.net ([205.152.58.64]:43687 "EHLO
	imf24bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280193AbRJaNVR>; Wed, 31 Oct 2001 08:21:17 -0500
Message-ID: <3BDFFAF0.CC46246F@mandrakesoft.com>
Date: Wed, 31 Oct 2001 08:21:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pre6, user stuck in sysrq
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i686 running 2.4.14-pre6.

In X, switch to console, hit sysrq-m.  sysrq-m output appears.  hit
<alt><f7> to switch back into X.  sysrq help menu appears twice (once
for <alt>, once for <f7>).  hit <alt><f2> to switch consoles.  help menu
appears twice again.

all other key combinations I tried kept interpreting -each- keystroke as
a sysrq command.  ie. once I ran a single sysrq command, I was
permanently in "sysrq mode."

umounted and rebooted using sysrq :)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

