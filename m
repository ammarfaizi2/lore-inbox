Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTFMJCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTFMJCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:02:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:20541 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265284AbTFMJCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:02:15 -0400
Date: Fri, 13 Jun 2003 02:17:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm9
Message-Id: <20030613021711.402297df.akpm@digeo.com>
In-Reply-To: <20030613013337.1a6789d9.akpm@digeo.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2003 09:16:01.0881 (UTC) FILETIME=[68BB8C90:01C3318C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> +mark-inode-dirty-debug.patch

This will print "__mark_inode_dirty: this cannot happen" when the machine
first starts to swap.  Please ignore it.

