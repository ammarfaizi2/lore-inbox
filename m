Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUJOUwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUJOUwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJOUwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:52:33 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:60349 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268360AbUJOUwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:52:32 -0400
Date: Fri, 15 Oct 2004 22:52:42 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015205242.GK17849@dualathlon.random>
References: <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random> <20041015183025.GN5607@holomorphy.com> <20041015184009.GG17849@dualathlon.random> <20041015184713.GO5607@holomorphy.com> <20041015192313.GH17849@dualathlon.random> <20041015204123.GP5607@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015204123.GP5607@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 01:41:23PM -0700, William Lee Irwin III wrote:
> though not a commonly used one on Linux.

I guess this is also because it's a no-way on x86.
