Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUJYTsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUJYTsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbUJYTsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:48:20 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:37523 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261255AbUJYTru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:47:50 -0400
Date: Mon, 25 Oct 2004 21:48:13 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] statm: shared = rss - anon_rss
Message-ID: <20041025194813.GK14325@dualathlon.random>
References: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain> <Pine.LNX.4.44.0410241647080.12023-100000@localhost.localdomain> <20041025193016.GX17038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025193016.GX17038@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 12:30:16PM -0700, William Lee Irwin III wrote:
> The group maintaining the tools relying upon the properties of the
> shared field of statm at Oracle has gone beyond code inspection of the
> patches, and as of today has carried out runtime testing of your
> patches and verified that it resolves the issue to their full
> satisfaction during runtime operation of the tools.

ok cool, thanks for the info.
