Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbTJAVGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbTJAVGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:06:44 -0400
Received: from quechua.inka.de ([193.197.184.2]:60302 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262553AbTJAVGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:06:43 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20030912044820.GG26618@matchmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E1A4oAm-0005p3-00@calista.inka.de>
Date: Wed, 01 Oct 2003 23:06:12 +0200
X-Scanner: exiscan *1A4oAm-0005p3-00*iuwYBBFUh6k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030912044820.GG26618@matchmail.com> you wrote:
> And if you have no superblock how does it know where the journal is?

You can search it by magic number, asume a fixed start location or whatever.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
