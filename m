Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270590AbTGTBgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 21:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270593AbTGTBgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 21:36:21 -0400
Received: from quechua.inka.de ([193.197.184.2]:64686 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S270590AbTGTBf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 21:35:59 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port SquashFS to 2.6
In-Reply-To: <7vk7ae15ty.fsf@assigned-by-dhcp.cox.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19e3Lj-0003xR-00@calista.inka.de>
Date: Sun, 20 Jul 2003 03:50:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <7vk7ae15ty.fsf@assigned-by-dhcp.cox.net> you wrote:
> +config SQUASHFS
> +       tristate "SquashFs file system support"
> +       help
> +         Saying Y here includes support for SquashFs.
> +
> +         If unsure, say N.
> +

This is not a useful help.

> + * Squashfs - a compressed read only filesystem for Linux

Please at least add this single sentence.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
