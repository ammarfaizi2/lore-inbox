Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUGHA5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUGHA5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUGHA5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 20:57:10 -0400
Received: from mail.3miasto.net ([153.19.176.2]:26612 "EHLO serwer.3miasto.net")
	by vger.kernel.org with ESMTP id S265701AbUGHA5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 20:57:09 -0400
Date: Thu, 8 Jul 2004 02:57:04 +0200 (CEST)
From: Leszek Koltunski <leszek@serwer.3miasto.net>
To: linux-kernel@vger.kernel.org
Subject: the old 'Unknown HZ value' bug
Message-ID: <Pine.NEB.4.60.0407080250190.5702@serwer.3miasto.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I keep getting the bug at random times. My googling resulted in a bunch of 
posts claiming that the problem is related to SMP systems and possibly to 
uptime. But not in my case- I do not have a SMP system and I sometimes get 
the bug right after bootup. SMP support is turned off, as you can see in 
my config:

www.3miasto.net/~leszek/config.html

I was getting it with 2.4.17, 2.4.24, and every single 2.6.x .
( I haven't tested other 2.4.x's )

Leszek
