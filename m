Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUANKit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUANKit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:38:49 -0500
Received: from relay.materna.de ([193.96.115.65]:57491 "EHLO relay.materna.de")
	by vger.kernel.org with ESMTP id S265113AbUANKis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:38:48 -0500
From: Tobias Wollgam <tobias.wollgam@materna.de>
Organization: Materna GmbH
To: linux-kernel@vger.kernel.org
Subject: initramfs vs. multiboot
Date: Wed, 14 Jan 2004 11:38:44 +0100
User-Agent: KMail/1.5.94
Cc: Tobias Wollgam <tobias.wollgam@materna.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401141138.44290.tobias.wollgam@materna.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me (I have trouble receiving mails from this list)

Hello.

I use pxegrub to boot a kernel + initrd from network. I want to support 
many (very old to very new) hardware. I like the idea of the multiboot 
spec, where grub can load single modules per tftp from server and 
extend the kernel in this way.

Now with kernel version 2.6 initramfs is upcoming, but I didn't found 
useful documentation of initramfs' possibilities and how to use them.

Could a bootloader decide with modules to append to the kernel?
If yes how?

TIA,

	Tobias
