Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbTHOStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270730AbTHOSt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:49:29 -0400
Received: from dp.samba.org ([66.70.73.150]:20654 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270805AbTHOSrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:47:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Fix loose->lose typos in 2.6.0-test2 
Date: Sat, 16 Aug 2003 03:12:52 +1000
Message-Id: <20030815184720.A65182CE83@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I cringe every time I see `loose' used where `lose' is intended.
> Here's a fix for the few that escaped the attentions of the spelling mafia...

Me too, however...

After a brief conversation with Andrew, Trivial Patch Monkey is only
taking patches for documentation and where grep might be effected.
Feel free to push this directly though.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
