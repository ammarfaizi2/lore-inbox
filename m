Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWHHDlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWHHDlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWHHDlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:41:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37771 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932318AbWHHDlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:41:05 -0400
Subject: Re: [PATCH 1 of 2] cpumask: use EXPORT_SYMBOL_GPL for new exports
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060807203914.6aec29df.akpm@osdl.org>
References: <1155007534.29877.215.camel@hole.melbourne.sgi.com>
	 <20060807203914.6aec29df.akpm@osdl.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1155008446.29877.219.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 08 Aug 2006 13:40:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 13:39, Andrew Morton wrote:
> All the existing exports in lib/cpumask.c are EXPORT_SYMBOL() so I'd be
> inclined to make any new exports match that.
> 
> <edits the diffs>
> 
> OK?

Fine by me.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


