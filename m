Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263419AbSJFMWX>; Sun, 6 Oct 2002 08:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbSJFMWW>; Sun, 6 Oct 2002 08:22:22 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:32198 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263419AbSJFMWR>; Sun, 6 Oct 2002 08:22:17 -0400
Message-ID: <20021006122643.28822.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 06 Oct 2002 20:26:43 +0800
Subject: [MICE] 2.5.40
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I can not be able to use both my touchpad mouse and pointer mouse working using any 2.5.* kernel.
2.4.* works just fine.

2.5.40$ dmesg | grep MOUSE
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
logibm.c: Didn't find Logitech busmouse at 0x23c

PS/2 mouse device should be my touchpad mouse.

Any hints ?

Ciao,
           Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
