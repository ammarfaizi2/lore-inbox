Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbULPXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbULPXVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbULPXVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:21:40 -0500
Received: from quechua.inka.de ([193.197.184.2]:43686 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262002AbULPXVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:21:36 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041216144531.3a8d988c@lembas.zaitcev.lan>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Cf4wA-0008U5-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 17 Dec 2004 00:21:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041216144531.3a8d988c@lembas.zaitcev.lan> you wrote:
> No way, Jan is out of his mind, adding obfuscations like that.
...
> Otherwise, /dbg sounds good.

I dont think that a root level directory, especially with an unreadable name
is a good idea. Why dont we at least try to keep the  namespace clean?

Greetings
Bernd
