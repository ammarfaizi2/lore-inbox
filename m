Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCVWwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUCVWwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:52:30 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:13574 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261171AbUCVWw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:52:28 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Warne <nick@ukfsn.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <4041E38F.31264.2D8C0D2E@localhost>
	<4043811B.24524.33DB8886@localhost> <405F57F2.7010308@pobox.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 23 Mar 2004 07:51:39 +0900
In-Reply-To: <405F57F2.7010308@pobox.com>
Message-ID: <87n068mr5w.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> What was the final resolution of the 8139too debugging?

http://marc.theaimsgroup.com/?l=linux-kernel&m=107919285122190&w=2

The cause of his problem was BIOS configuration. It was edge-trigger.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
