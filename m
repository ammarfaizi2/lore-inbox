Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUE1Ufa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUE1Ufa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUE1Ufa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:35:30 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:1239 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261602AbUE1UfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:35:24 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Proposal] DEBUG_SLAB should select DEBUG_SPINLOCK
References: <528yfc72u8.fsf@topspin.com>
	<20040528124228.105ebcbb.rddunlap@osdl.org>
	<52zn7s5nus.fsf@topspin.com>
	<20040528130003.69a1e7c9.rddunlap@osdl.org>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 28 May 2004 13:35:23 -0700
In-Reply-To: <20040528130003.69a1e7c9.rddunlap@osdl.org>
Message-ID: <52vfig5lys.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 May 2004 20:35:23.0646 (UTC) FILETIME=[4D37C9E0:01C444F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Randy> You can wait, or send it to Andrew for merging (it will
    Randy> just be one more small change for me), or send it to me for
    Randy> Kconfig.debug.

    Randy> I won't lose it, but it's probably safer just to send it to
    Randy> Andrew, and I can deal with that small diff later.

I'm going to wait to make my patch so that I don't have to change
every single arch Kconfig file to add the same line to the DEBUG_SLAB
stanza.

 - R.

