Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSBSEUA>; Mon, 18 Feb 2002 23:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289655AbSBSETt>; Mon, 18 Feb 2002 23:19:49 -0500
Received: from web10504.mail.yahoo.com ([216.136.130.154]:50187 "HELO
	web10504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289653AbSBSETo>; Mon, 18 Feb 2002 23:19:44 -0500
Message-ID: <20020219041943.64764.qmail@web10504.mail.yahoo.com>
Date: Mon, 18 Feb 2002 20:19:43 -0800 (PST)
From: S W <egberts@yahoo.com>
Subject: 2.4.18-rc1 page_alloc.c:199 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.18-rc1 produced a page_alloc.c:199 kernel
bug regularly and with increasing probability as
system loads increases.

Am shedding modules to narrow this down and reassess.

Running 1GHz Cyrix III, RTL8136 Ethernet, Ipchains w/o rulesets.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
