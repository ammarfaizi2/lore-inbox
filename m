Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUEOTcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUEOTcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264716AbUEOTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:32:41 -0400
Received: from lucidpixels.com ([66.45.37.187]:39314 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S264692AbUEOTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:32:35 -0400
Date: Sat, 15 May 2004 15:32:30 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
Message-ID: <Pine.LNX.4.58.0405151530590.16044@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Script started on Sat May 15 14:47:08 2004
# modprobe emu10k1
FATAL: Error inserting emu10k1
(/lib/modules/2.6.5/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
root@war:~# dmesg | tail -n 1
 emu10k1: Unknown symbol strcpy

