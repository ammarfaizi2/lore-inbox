Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUE1T5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUE1T5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUE1Ty6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:54:58 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:62161 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263845AbUE1Tyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:54:36 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Proposal] DEBUG_SLAB should select DEBUG_SPINLOCK
References: <528yfc72u8.fsf@topspin.com>
	<20040528124228.105ebcbb.rddunlap@osdl.org>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 28 May 2004 12:54:35 -0700
In-Reply-To: <20040528124228.105ebcbb.rddunlap@osdl.org>
Message-ID: <52zn7s5nus.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 May 2004 19:54:35.0759 (UTC) FILETIME=[9A29DFF0:01C444ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Randy> Andrew asked me to delay it until 2.6.6, which I did.  Sent
    Randy> that, but not merged.

    Randy> I will be rediffing it and resending it again for 2.6.7 and
    Randy> probably some intermediate kernels if that's what it takes.

Thanks for the info.  I guess I'll wait for your patch to be merged
and then send my (trivial) patch.

 - Roland
