Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUFSPvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUFSPvr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUFSPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:51:46 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:20355 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264054AbUFSPv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:51:29 -0400
Subject: Why dentry->d_qstr change in 2.6.7 ?
From: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: The Umbrella Team <umbrella@cs.auc.dk>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1087660293.30405.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 17:51:33 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Anyone know why the dentry->d_qstr in linux-2.6.7 has changed to
dentry->d_name? (structure dentry defined in include/linux/dcache.h)


Cheers, KS.
-- 
Kristian Sørensen <ks@cs.auc.dk>

