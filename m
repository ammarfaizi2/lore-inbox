Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWAWFdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWAWFdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWAWFdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:33:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964800AbWAWFdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:33:41 -0500
Date: Sun, 22 Jan 2006 21:33:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] device-mapper snapshot: load metadata on creation
Message-Id: <20060122213311.2aa12eb6.akpm@osdl.org>
In-Reply-To: <20060120211116.GB4724@agk.surrey.redhat.com>
References: <20060120211116.GB4724@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> If you're using lvm2, for this patch to work properly you should update 
>  to lvm2 version 2.02.01 or later and device-mapper version 1.02.02 or later.

If people are using older tools and they run with this patch, what will
happen to them?

