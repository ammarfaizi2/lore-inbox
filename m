Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWAMHvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWAMHvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWAMHvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:51:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:33152 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932649AbWAMHvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:51:53 -0500
Date: Fri, 13 Jan 2006 09:51:52 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: remove kmalloc wrapper
In-Reply-To: <20060112234846.3a20f5a1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601130951160.22049@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
 <20060112233920.4b3b0a26.akpm@osdl.org> <Pine.LNX.4.58.0601130942540.20349@sbz-30.cs.Helsinki.FI>
 <20060112234846.3a20f5a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006, Andrew Morton wrote:
> It would have helped had you described the exact /proc pathname so people
> could remember whether there's anything which actually uses it.

That would be /proc/fs/reiserfs/super, I think.

			Pekka
