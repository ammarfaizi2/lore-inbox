Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSLBSX1>; Mon, 2 Dec 2002 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSLBSX0>; Mon, 2 Dec 2002 13:23:26 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:25750 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264711AbSLBSXZ>; Mon, 2 Dec 2002 13:23:25 -0500
Date: Mon, 2 Dec 2002 23:30:50 +0100
From: Keats <neokeats@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Possible Module Loader bug...
Message-Id: <20021202233050.66669be9.neokeats@wanadoo.fr>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ! :) 

Kernel version : 2.5.50
lsmod 
QM_MODULES: function not implemented

all functions lsmod, depmod, rmmod, modprobe... don't work 
although i think, i've module support on the kernel... 
cat .config | grep -i module
# Loadable module support
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set

is there anyone who have the same problem ? 

++
Keats.
