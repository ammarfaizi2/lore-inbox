Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbRGUMle>; Sat, 21 Jul 2001 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbRGUMlZ>; Sat, 21 Jul 2001 08:41:25 -0400
Received: from [200.222.193.212] ([200.222.193.212]:29086 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S267624AbRGUMlG>; Sat, 21 Jul 2001 08:41:06 -0400
Date: Sat, 21 Jul 2001 09:41:00 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_PARPORT_PC_CML1 ?
Message-ID: <20010721094100.B11246@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.19i
X-Mailer: Mutt/1.3.19i - Linux 2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi. What's CONFIG_PARPORT_PC_CML1 ? I just ran make oldconfig
and doing a diff against my 2.4.6 .config noticed that
CONFIG_PARPORT_PC_CML1=m was added.

There's nothing about such option in drivers/parport/Makefile
. Am I missing something ?

TIA.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
