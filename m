Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUIESQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUIESQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUIESQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 14:16:57 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:49381 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265999AbUIESQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 14:16:54 -0400
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: linux-kernel@vger.kernel.org
Subject: Quick Syscall question
Date: Sun, 5 Sep 2004 13:17:42 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409051317.42691.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This may seem like a silly question, however we were all beginning 
programmers once ;)

	I want to do some manipulating of network interfaces and routing and such. I 
am reading through some of the linux net sources but am confused on what are 
internal, kernel-only functions and what are externally visable syscalls. How 
can I tell from the source what is user-space visable that I can hook into 
and what is intternel stuff? Should I just be looking at headers or do I have 
to delve into the .c sources? I can do either, I just need a pointer on where 
to start and what I should be looking for.

Thanks
-- 

-EB
