Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbTFIKk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFIKk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:40:56 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:58309 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S262528AbTFIKkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:40:55 -0400
Subject: Completely disable AT/PS2 keyboard support in 2.4?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1055156075.3824.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jun 2003 12:54:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible to completely disable AT/PS2 keyboard support
in 2.4 or is this still needed when I only use a USB keyboard?

I am currently getting dozens of keyboard messages:

keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272
keyboard.c: can't emulate rawmode for keycode 272

I am not sure if the comes from the USB keyboard or from
the non-connected PS2 port.

Thanks,

Jurgen

