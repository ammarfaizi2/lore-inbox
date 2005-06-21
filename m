Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFUAu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFUAu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVFUAt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:49:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261880AbVFUAe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 20:34:57 -0400
Date: Mon, 20 Jun 2005 17:35:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: -mm patch glut
Message-Id: <20050620173549.6d064fe7.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various people have sent me things in the past few days: thanks, it is
queued for now.

There's a lot of stuff in -mm to go through (I'll put a summary out soon). 
For now, I'm concentrating on cleaning up the diffs and changelogs, poking
reviewers, stabilisation, testing and, once the various subsystem
maintainers (Greg) have done thir bit, merging.

I'll be looking for things to drop, too - it's getting a bit crazy.
