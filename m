Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWCaR0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWCaR0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWCaR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:26:53 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:38582 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932084AbWCaR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:26:52 -0500
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] locks: cleanups and fixes
Message-Id: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:26:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are small changes to the POSIX locking code.  Most of them are
needed for locking support in FUSE, but also make sense independently
as bug fixes and/or cleanups.

Miklos
