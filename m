Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVGJVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVGJVoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVGJVmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 17:42:02 -0400
Received: from quechua.inka.de ([193.197.184.2]:54711 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262114AbVGJVke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 17:40:34 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050710125438.GA17784@animx.eu.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DrjXM-0000qx-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 10 Jul 2005 23:40:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050710125438.GA17784@animx.eu.org> you wrote:
> So are you saying that if I create a swap partition it's best to use dd to
> zero it out before mkswap?

Nope I did not. However I dont know of any other shell tool which can do it
that easyly.

> As far as portable, we're talking about linux, portability is not an issue
> in this case. 

Portability across Filesystems.

Gruss
Bernd
