Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbRG2KWT>; Sun, 29 Jul 2001 06:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267917AbRG2KWP>; Sun, 29 Jul 2001 06:22:15 -0400
Received: from [200.222.192.145] ([200.222.192.145]:7301 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S267915AbRG2KVk>; Sun, 29 Jul 2001 06:21:40 -0400
Date: Sun, 29 Jul 2001 07:21:52 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SLIP and slhc as modules
Message-ID: <20010729072152.K135@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.19i
X-Mailer: Mutt/1.3.19i - Linux 2.4.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi. I build PPP and SLIP as modules, but slhc is always built
in. In 2.4.7 I disabled SLIP, and slhc was built as a module.

Why not when I build SLIP as a module ?

I did a search and found a message from Philip Blundell:

http://uwsg.iu.edu/hypermail/linux/kernel/0102.1/0534.html

Nobody replied.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
