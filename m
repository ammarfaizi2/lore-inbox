Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSA3AZE>; Tue, 29 Jan 2002 19:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287595AbSA3AYs>; Tue, 29 Jan 2002 19:24:48 -0500
Received: from terminus.zytor.com ([64.158.222.227]:16015 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S287532AbSA3AXb>; Tue, 29 Jan 2002 19:23:31 -0500
Message-Id: <200201300023.g0U0NQZ26438@terminus.zytor.com>
Subject: master.kernel.org down
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Jan 2002 12:54:25 -0800 (PST)
From: hpa@zytor.com (H. Peter Anvin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

master.kernel.org is currently offline; it seems that some of the
preparation work for doing an OS upgrade later this week backfired and
triggered a problem (not necessarily a bug -- this was more in the
class of pilot error) with the RAID controller.  We are trying to
bring it back online, but it might take a while; if we can't we will
restore it from backups.

In the meantime ftp.kernel.org et al will operate normally, but will
not receive new updates.

	-hpa

[Apologies if this is a duplicate.  This hasn't been the only disaster
today.]
