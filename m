Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWAJLef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWAJLef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 06:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWAJLef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 06:34:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14482 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751055AbWAJLef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 06:34:35 -0500
Date: Tue, 10 Jan 2006 12:34:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060110113440.GA8541@elte.hu>
References: <20060107052221.61d0b600.akpm@osdl.org> <43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C38932.7070302@reub.net> <20060110104759.GA30546@elte.hu> <20060110105249.GA1528@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110105249.GA1528@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


could you also enable CONFIG_FRAME_POINTERS, to make the backtraces 
easier to read?

	Ingo
