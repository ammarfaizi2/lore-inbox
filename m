Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTD1MhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTD1MhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:37:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8576 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263422AbTD1MhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:37:16 -0400
Date: Mon, 28 Apr 2003 13:48:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030428124828.GA8906@mail.jlokier.co.uk>
References: <20030427022346.GA27933@averell> <20030428091616.GA27064@fs.tum.de> <20030428114717.GA6904@averell> <20030428121920.GE27064@fs.tum.de> <20030427022346.GA27933@averell> <20030428091616.GA27064@fs.tum.de> <20030428114717.GA6904@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428121920.GE27064@fs.tum.de> <20030428114717.GA6904@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Your approach as well as the approach I'm currently working on breaks
> the current semantics that a plain M386 produces a kernel that runs on
> all CPUs.

Good, because I _have_ a 386 and want a kernel that is tuned for it,
not a generic kernel.

cheers,
-- Jamie
