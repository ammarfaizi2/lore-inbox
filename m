Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUJAVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUJAVxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUJAVPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:15:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:51122 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266585AbUJAU4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:56:46 -0400
Date: Fri, 1 Oct 2004 14:00:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, piggin@cyberone.com.au, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
Message-Id: <20041001140013.5e3afc59.akpm@osdl.org>
In-Reply-To: <20041001190430.GA4372@logos.cnet>
References: <20041001182221.GA3191@logos.cnet>
	<20041001131147.3780722b.akpm@osdl.org>
	<20041001190430.GA4372@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> As far as I have researched, the memory moving/remapping code 
> on the hot remove patches dont work correctly. Please correct me.
> 
> And what I've seen (from the Fujitsu guys) was quite ugly IMHO.

That's a totally different patch.
