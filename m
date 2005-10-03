Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVJCJUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVJCJUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVJCJUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:20:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:3487 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932196AbVJCJUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:20:06 -0400
To: =?iso-8859-1?q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14-rc4/x86_64]: Kernel BUG at mm/slab.c:1876
References: <Pine.BSO.4.62.0510021916400.28198@rudy.mif.pg.gda.pl>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2005 11:20:05 +0200
In-Reply-To: <Pine.BSO.4.62.0510021916400.28198@rudy.mif.pg.gda.pl>
Message-ID: <p73ll1b0xfe.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> writes:

> Hardware: Sun v20z

Should be fixed now in latest -git*. Please test.

-Andi
