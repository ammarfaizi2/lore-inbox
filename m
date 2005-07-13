Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVGMKVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVGMKVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVGMKVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:21:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:26563 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262545AbVGMKV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:21:29 -0400
Date: Wed, 13 Jul 2005 12:21:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: vacant2005@o2.pl
cc: linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <200507121834.50084.vacant2005@o2.pl>
Message-ID: <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr>
References: <200507121834.50084.vacant2005@o2.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>After compiling new kernel, it doesn`t load System.map file. In kernel 
>messages I can find:
>
>Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
>Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from /boot/System.map.
>Jul 11 12:18:48 localhost kernel: Symbols match kernel version 2.6.12.
>Jul 11 12:18:48 localhost kernel: No module symbols loaded - kernel modules 
>notenabled.

I get the same, but somehow, my symbols are loaded. (When it oopses, derefs 
a NULL pointer, etc. for example.)

(My syms file is at /boot/System.map-`uname -r` and "works" equally well to 
yours.)


Jan Engelhardt
-- 

