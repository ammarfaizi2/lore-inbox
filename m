Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTEGFkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbTEGFkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:40:40 -0400
Received: from [12.47.58.20] ([12.47.58.20]:33459 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262878AbTEGFkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:40:39 -0400
Date: Tue, 6 May 2003 22:53:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.69] IA64 sn mod_timer fixes for kernel/mca.c
Message-Id: <20030506225307.5ccb318f.akpm@digeo.com>
In-Reply-To: <1052283842.19524.44.camel@lima.royalchallenge.com>
References: <1052283842.19524.44.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 05:53:05.0659 (UTC) FILETIME=[EDDAC4B0:01C3145C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:
>
> mca.c: Trivial {del,add}_timer to mod_timer conversion.

Please just roll all these up into one big patch.
