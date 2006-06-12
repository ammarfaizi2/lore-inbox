Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWFLMtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWFLMtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWFLMtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:49:53 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7079 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751911AbWFLMtw (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:49:52 -0400
Date: Mon, 12 Jun 2006 14:49:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Arjan van de Ven <arjan@infradead.org>, rohitseth@google.com,
       Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
 physical pages backing it
In-Reply-To: <200606121317.44139.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0606121449140.1125@yvahk01.tjqt.qr>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
 <1150042142.3131.82.camel@laptopd505.fenrus.org> <200606121317.44139.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I agree it's a bad idea. smaps is only a debugging kludge anyways
>and it's not a good idea to we bloat core data structures for it.
>
Is there a way to disable it (smaps), then?


Jan Engelhardt
-- 
