Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUAMROo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbUAMROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:14:43 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:52358 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264419AbUAMROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:14:42 -0500
Date: Tue, 13 Jan 2004 17:14:39 +0000 (UTC)
From: dan@eglifamily.dnsalias.net
To: Nikita Danilov <Nikita@Namesys.COM>
cc: linux-kernel@vger.kernel.org,
       =?koi8-r?B?78zFxw==?= =?koi8-r?B?5NLPy8nO?= 
	<Green@LinuxHacker.RU>
Subject: Re: 2.6.x breaks some Berkeley/Sleepycat DB functionality
In-Reply-To: <16387.49164.269996.500699@laputa.namesys.com>
Message-ID: <Pine.LNX.4.44.0401131714170.27158-100000@eglifamily.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SA-Exim-Mail-From: dan@eglifamily.dnsalias.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Nikita Danilov wrote:

> On top of what file system berkdb is created? I have a reminiscence that
> Sleepy Cat used to have a problem with reiserfs, due to large
> stat->st_blksize value. Oleg do you remember this?

ext3


