Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbUJYGdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUJYGdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUJYGa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:30:56 -0400
Received: from holomorphy.com ([207.189.100.168]:63704 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261629AbUJYG3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:29:33 -0400
Date: Sun, 24 Oct 2004 23:29:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, andrea@novell.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] statm: shared = rss - anon_rss
Message-ID: <20041025062920.GV17038@holomorphy.com>
References: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain> <Pine.LNX.4.44.0410241647080.12023-100000@localhost.localdomain> <20041024160814.GT17038@holomorphy.com> <20041024232443.1a18eb44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024232443.1a18eb44.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 04:49:48PM +0100, Hugh Dickins wrote:
>>> Signed-off-by: Hugh Dickins <hugh@veritas.com>

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  Signed-off-by: William Irwin <wli@holomorphy.com>

On Sun, Oct 24, 2004 at 11:24:43PM -0700, Andrew Morton wrote:
> I'll change these three to "Acked-by:".  Unless you actually had a hand in
> developing these patches, in which case I'll unchange things.

Never seen that before. s/Signed-off/Acked/ is fine by me, and
probably more descriptive.


-- wli
