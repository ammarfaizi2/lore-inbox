Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUCJKxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUCJKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:53:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7910 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262575AbUCJKxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:53:06 -0500
Date: Wed, 10 Mar 2004 11:54:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC anon_vma previous (i.e. full objrmap)
Message-ID: <20040310105418.GA497@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309030907.71a53a7c.akpm@osdl.org> <20040309114924.GA4581@elte.hu> <20040309160307.GI8193@dualathlon.random> <20040310103610.GB30940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310103610.GB30940@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> btw, try your exploit by keeping the stuff mlocked. [...]

btw., why do you insist on calling it an 'exploit'? It's a testcase - it
does things that real applications do too.

	Ingo
