Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVDEGBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVDEGBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDEGBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:01:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57817 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261567AbVDEGBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:01:06 -0400
Date: Mon, 4 Apr 2005 23:01:01 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU in kernel/intermodule.c
Message-ID: <20050404230101.206a7302@lembas.zaitcev.lan>
In-Reply-To: <mailman.1112627017.26915.linux-kernel2news@redhat.com>
References: <mailman.1112627017.26915.linux-kernel2news@redhat.com>
X-Mailer: Sylpheed-Claws 1.0.1cvs20.1 (GTK+ 2.6.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Apr 2005 11:28:12 +0000 Luca Falavigna <dktrkranz@gmail.com> wrote:

> This patch, compiled against version 2.6.12-rc1, implements RCU mechanism in
> intermodule functions.

This sounds like a pure and unmitigated insanity to me. Please tell us
why in the world you wanted to do this.

-- Pete
