Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUEOHnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUEOHnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 03:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUEOHnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 03:43:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13425 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264660AbUEOHnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 03:43:15 -0400
Date: Sat, 15 May 2004 08:43:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2
In-Reply-To: <20040515024336.GN3044@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0405150840590.4115-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004, Andrea Arcangeli wrote:
> paging, paging of nonlinear VMAs works fine, but the truncate of the
> nonlinear vmas doesn't work yet correctly. This will be eventually fixed

Already fixed in 2.6.6: look for "details" in mm/memory.c.

Hugh

