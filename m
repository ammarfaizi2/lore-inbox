Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbULLPo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbULLPo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 10:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULLPo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 10:44:29 -0500
Received: from rain.plan9.de ([193.108.181.162]:19107 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262087AbULLPoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 10:44:11 -0500
Date: Sun, 12 Dec 2004 16:44:06 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Improved console UTF-8 support for the Linux kernel?
Message-ID: <20041212154406.GA23451@schmorp.de>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo> <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr> <1102803807.3183.59.camel@kl> <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>
X-Operating-System: Linux version 2.6.9 (root@fuji) (gcc version 3.3.4 (Debian 1:3.3.4-13)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 01:05:49AM +0100, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> Can anyone elaborate on this graphical mouse stuff?

What norton does is simply use a few characters that happen to look like a
mouse cursor on characters (or norton forces to look, more correctly). You
can do that for a single object (like the mouse cursor), and a few more,
but of course you can display much less characters that way than with a
standard method, as it eats 4 characters/object.

-- 
                The choice of a                              |
      -----==-     _GNU_                                     |
      ----==-- _       generation     Marc Lehmann         +--
      ---==---(_)__  __ ____  __      pcg@goof.com         |e|
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/   --+
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE            |
                                                           |
