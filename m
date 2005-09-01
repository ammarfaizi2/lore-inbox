Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVIAAdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVIAAdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVIAAdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:33:42 -0400
Received: from quechua.inka.de ([193.197.184.2]:10423 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S964998AbVIAAdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:33:42 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050901012218.02c79560.diegocg@gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1EAd1J-0007Cw-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 01 Sep 2005 02:33:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050901012218.02c79560.diegocg@gmail.com> you wrote:
> I mean, nvidia people also use propietary code in the kernel (probably
> violating the GPL anyway) and don't do such things.

The Linux kernel allows binary drivers, you just have to live with a limited
number of exported symbols and that the kernel is tainted. Which basically
means nobody sane can help you with corrupted kernel data structures.

Bernd
