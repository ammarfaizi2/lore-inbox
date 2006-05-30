Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWE3BaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWE3BaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWE3B3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:29:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751557AbWE3B3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:37 -0400
Date: Mon, 29 May 2006 18:33:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 12/61] lock validator: beautify x86_64 stacktraces
Message-Id: <20060529183350.7e02336a.akpm@osdl.org>
In-Reply-To: <20060529212405.GL3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212405.GL3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:05 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> beautify x86_64 stacktraces to be more readable.

One reject fixed due to the backtrace changes in Andi's tree.

I'll get all this compiling, but we'll need to review and test the end
result please, make sure that it all landed OK.

