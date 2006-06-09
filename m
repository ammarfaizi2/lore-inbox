Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWFIBMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWFIBMy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWFIBMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:12:54 -0400
Received: from hermes.hosts.co.uk ([212.84.175.24]:48042 "EHLO
	pallas.hosts.co.uk") by vger.kernel.org with ESMTP id S965069AbWFIBMy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:12:54 -0400
To: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
From: =?utf-8?q?=22Felix=20Oxley=22?= <lkml@oxley.org>
Reply-To: =?utf-8?q?=22Felix=20Oxley=22?= <lkml@oxley.org>
Subject: =?utf-8?q?Re=3a=202=2e6=2e17=2drc6=3a=20Fails=20to=20compile=20on=20PowerBook=20=3c=3c=20PLEASE=20IGNORE?=
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <E1FoVYV-0005Qr-8L@mercury.hosts.co.uk>
Date: Fri, 09 Jun 2006 02:12:55 +0100
X-Spam-Score: -4.4 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 9/6/06 2:04 AM, Felix Oxley <lkml@oxley.org> wrote:

> Suse 10.1:
>
> CC      mm/util.o
> CC      mm/mmzone.o
> CC      mm/fremap.o
> LD      mm/built-in.o
> CC [M]  fs/configfs/inode.o
> objdump: 'fs/configfs/.tmp_inode.o': No such file
> mv: cannot stat `fs/configfs/.tmp_inode.o': No such file or directory
> make[2]: *** [fs/configfs/inode.o] Error 1
> make[1]: *** [fs/configfs] Error 2
> make: *** [fs] Error 2
>
> //felix
>

Please ignore this message. I screwed up :-(
//felix
