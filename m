Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUHJA6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUHJA6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267373AbUHJA6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:58:52 -0400
Received: from quechua.inka.de ([193.197.184.2]:41131 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265053AbUHJA6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:58:51 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <41180443.9030900@comcast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BuKyX-0005hJ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 10 Aug 2004 02:58:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41180443.9030900@comcast.net> you wrote:
> The large amount of extra commentary is worth it, IMHO.

This is a typical coding problem:

- no comments are better than wrong comments
- code which is understandable w/o comments is better than commented code

And of course there is a kernel comment style.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
