Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWHaQ0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWHaQ0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWHaQ0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:26:10 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:33992 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932369AbWHaQ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:26:08 -0400
Date: Thu, 31 Aug 2006 12:17:15 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: - i386-early-fault-handler.patch removed from -mm tree
To: "akpm@osdl.org" <akpm@osdl.org>, mingo@elte.hu, ak@muc.de
Cc: pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
Message-ID: <200608311221_MC3-1-C9EE-3549@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608310422.k7V4M8Xu023875@shell0.pdx.osdl.net>

On Wed, 30 Aug 2006 21:22:08 -0700, Andrew Morton wrote:

> The patch titled
> 
>      i386: early fault handler
> 
> has been removed from the -mm tree.  Its filename is
> 
>      i386-early-fault-handler.patch
> 
> This patch was dropped because a different version got merged by andi

<*sigh*>

Didn't anyone even notice the fix that was already in -mm?  Now we're back
to "guess which fault it was" when an early fault occurs.

-- 
Chuck

