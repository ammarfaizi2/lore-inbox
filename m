Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUKITkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUKITkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUKITkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:40:16 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18960 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261641AbUKITkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:40:12 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Return better error codes from
 vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109013848.GC6835@neapel230.server4you.de>
	<87vfcf3uu0.fsf@devron.myhome.or.jp>
	<20041109164902.GA14088@neapel230.server4you.de>
	<87bre7j58b.fsf@devron.myhome.or.jp>
	<20041109183556.GB15288@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 04:08:56 +0900
In-Reply-To: <20041109183556.GB15288@neapel230.server4you.de> (Rene
 Scharfe's message of "Tue, 9 Nov 2004 19:35:56 +0100")
Message-ID: <87oei6kfg7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Yes. I removed the check and rediffed the patch against the one I sent
> a few minutes ago.

Thanks. I'll submit after 2.6.10.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
