Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSKCL70>; Sun, 3 Nov 2002 06:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSKCL70>; Sun, 3 Nov 2002 06:59:26 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:45582 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261755AbSKCL7Z>; Sun, 3 Nov 2002 06:59:25 -0500
Message-Id: <200211031200.gA3C04p27922@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: 2.5.45: make menuconfig: (NEW) disappears once touched
Date: Sun, 3 Nov 2002 14:52:02 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I go to any item marked (NEW), like this:

< > Gameport support (NEW)

and press y,n or m (does not matter), it gets
appropriately selected but '(NEW)' disappers.
Why?
--
vda
