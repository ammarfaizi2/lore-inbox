Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUJOV2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUJOV2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUJOV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:28:45 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:32482 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S268457AbUJOV2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:28:44 -0400
Date: Fri, 15 Oct 2004 23:28:31 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015212831.GL17849@dualathlon.random>
References: <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random> <20041015183025.GN5607@holomorphy.com> <20041015184009.GG17849@dualathlon.random> <20041015184713.GO5607@holomorphy.com> <20041015211626.GQ5607@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015211626.GQ5607@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 02:16:26PM -0700, William Lee Irwin III wrote:
> they're only waiting for ports to the vendor kernel(s) now.

Ok fine. But first it has to be included into mainline, then of course
we'll merge it. Fixing Oracle at the expense of being incompatible with
the user-ABI with future 2.6 is a no-way.
