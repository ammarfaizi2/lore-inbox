Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbTILBUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbTILBUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:20:41 -0400
Received: from quechua.inka.de ([193.197.184.2]:63152 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261622AbTILBUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:20:41 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
In-Reply-To: <20030912005007.B11566@bitwizard.nl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19xcc1-0000mF-00@calista.inka.de>
Date: Fri, 12 Sep 2003 03:20:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030912005007.B11566@bitwizard.nl> you wrote:
> at all. But no backup superblock, is just plain wrong. 

this totally depends on the capabilities of the fsck and in-kerlen journal
replay code, if they can reconstruct the data in there.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
