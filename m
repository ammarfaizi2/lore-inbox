Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUBZAzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUBZAzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:55:35 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:40756 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262581AbUBZAze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:55:34 -0500
Date: Wed, 25 Feb 2004 19:55:24 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Timothy Miller <miller@techsource.com>
cc: Grigor Gatchev <grigor@zadnik.org>,
       Christer Weinigel <christer@weinigel.se>,
       Nikita Danilov <Nikita@Namesys.COM>, <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <403D325F.9070907@techsource.com>
Message-ID: <Pine.LNX.4.44.0402251955040.8976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Timothy Miller wrote:

> I think TOE (TCP/IP stack on the ethernet card) might be one of those 
> things which doesn't fit cleanly into the layered model.

That's not a big problem though, as long as the Linux network
stack keeps outperforming TOE adapters ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

