Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbTL3Kh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265741AbTL3Kh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:37:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:57273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265740AbTL3Khz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:37:55 -0500
Date: Tue, 30 Dec 2003 02:37:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: jgarzik@pobox.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optimize ia32 memmove
Message-Id: <20031230023757.474e5c0f.akpm@osdl.org>
In-Reply-To: <3FF151AD.1080703@wmich.edu>
References: <200312300713.hBU7DGC4024213@hera.kernel.org>
	<3FF129F9.7080703@pobox.com>
	<3FF151AD.1080703@wmich.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <ed.sweetman@wmich.edu> wrote:
>
> Is this the entire patch?  When was the original post since I cant find 
> the message going back over a month ago in the archives or any current 
> posts.
> 

The original patch is on the 2.5/2.6 commits mailing list,
bk-commits-head@vger.kernel.org.  That list sets
linux-kernel@vger.kernel.org as the From: address, so replies come here.
