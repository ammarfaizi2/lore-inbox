Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbTCaTX6>; Mon, 31 Mar 2003 14:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbTCaTX6>; Mon, 31 Mar 2003 14:23:58 -0500
Received: from smtp02.web.de ([217.72.192.151]:11041 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S261803AbTCaTX4>;
	Mon, 31 Mar 2003 14:23:56 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig error
Date: Mon, 31 Mar 2003 21:34:38 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303312134.38818.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I don't know, if this was posted some time ago, because I was unsubscribed
for a time.
I unpacked a vanilla 2.5.66, copied the .config of my already configured
2.5.64 to the new kernel, made a make menuconfig and immediately canceled
it, without saving.
I got this error-message:

# bla ...
  gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o scripts/lxdialog/util.o scripts/lxdialog/lxdialog.o scripts/lxdialog/msgbox.o -lncurses 
./scripts/kconfig/mconf arch/i386/Kconfig
#
# using defaults found in .config
#
.config:763: trying to assign nonexistent symbol INTEL_RNG


Your kernel configuration changes were NOT saved.



Regards Michael Buesch.

