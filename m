Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUF0Nba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUF0Nba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUF0Nb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:31:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:29019 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261563AbUF0Nb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:31:28 -0400
Message-ID: <34608.192.168.1.9.1088343088.squirrel@192.168.1.9>
Date: Sun, 27 Jun 2004 15:31:28 +0200 (CEST)
Subject: problem with keyboard lagging (2.6.6, 2.6.7vanilla and mm2)
From: "Redeeman" <lkml@metanurb.dk>
To: linux-kernel@vger.kernel.org
Reply-To: lkml@metanurb.dk
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, my brother just tried to install 2.6.7-mm2 on his computer, its a
amd64 3200+ with a asus k8v deluxe motherboard.
the thing that happens is, that stuff simply lags, the cpu is not being
heavily used, but when typing in the console, it gets strange, and types
like 1 character per second. booting in vmware and it works perfect.
then he tried 2.6.7 vanilla, the same result, and finally, he tried
2.6.6vanilla, and its also the same result.

2.6.2 worked fine.

hope you have some ideas.


-- 
Redeeman

