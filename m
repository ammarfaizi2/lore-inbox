Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbTAQD5T>; Thu, 16 Jan 2003 22:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbTAQD5S>; Thu, 16 Jan 2003 22:57:18 -0500
Received: from exmsb01.curtin.edu.au ([134.7.171.75]:65291 "EHLO
	exmsb01.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S267246AbTAQD5R>; Thu, 16 Jan 2003 22:57:17 -0500
Message-ID: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au>
From: Carl Gherardi <C.Gherardi@curtin.edu.au>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.5.59
Date: Fri, 17 Jan 2003 12:06:03 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

Just done a bk pull and got this

# make mrproper; make menuconfig
....
gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o
scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o
scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o scripts/lxdialog/util.o
scripts/lxdialog/lxdialog.o scripts/lxdialog/msgbox.o -lncurses
./scripts/kconfig/mconf arch/i386/Kconfig
arch/i386/Kconfig:1185: can't open file "drivers/eisa/Kconfig"
make: *** [menuconfig] Error 1

Carl
