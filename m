Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270821AbTG0PP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270825AbTG0PP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:15:26 -0400
Received: from quechua.inka.de ([193.197.184.2]:20623 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S270821AbTG0PPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:15:19 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1059315015.10692.207.camel@sonja>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19gnTj-00005f-00@calista.inka.de>
Date: Sun, 27 Jul 2003 17:30:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1059315015.10692.207.camel@sonja> you wrote:
> This is normally done by the filesystem (e.g. JFFS2).

why is jffs2 so slow, if the cpu overhead can be totally neglected when
writing to such slow media? I would asume a FS whic his optimized for not
wearing out flash cards would reduce the IOs to the absolute minimum and
therefore be fast be definition?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
