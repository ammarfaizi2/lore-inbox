Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269915AbUJGXGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269915AbUJGXGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269914AbUJGXBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:01:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:33733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269901AbUJGWur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:50:47 -0400
Date: Thu, 7 Oct 2004 15:54:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007155441.5a8e8e3a.akpm@osdl.org>
In-Reply-To: <1097188883l.6408l.1l@werewolf.able.es>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
	<1097184341l.10532l.0l@werewolf.able.es>
	<1097185597l.10532l.1l@werewolf.able.es>
	<20041007150708.5d60e1c3.akpm@osdl.org>
	<1097188883l.6408l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> Thanks, that made it work again !!
> 
> Total set of patches to boot:
> - your latest fix
> - revert optimize profile + Andi's patch
> - uhci fix (still needed ?)

I don't know anything about the uhci fix.  Sending a changelogged,
signed-off patch would hep get the ball rolling.

> - e100 fix (only thing I have seen at the moment...)

What's this and why is it needed?

> - 1Gb lowmem
> 
> How about including the last one in -mm, for testing ? I use it in a server
> and in my home workstation and it works fine (even with nvidia drivers ;) ).

Never seen it before.

