Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbUBZRM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUBZRM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:12:56 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:38536 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262865AbUBZRMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:12:54 -0500
Date: Thu, 26 Feb 2004 12:12:14 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Timothy Miller <miller@techsource.com>, Grigor Gatchev <grigor@zadnik.org>,
       Christer Weinigel <christer@weinigel.se>,
       Nikita Danilov <Nikita@Namesys.COM>, <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <04022609432200.08433@tabby>
Message-ID: <Pine.LNX.4.44.0402261211510.5629-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Jesse Pollard wrote:

> Until you add IPSEC...
> 
> Unless the TOE has the same security support (encrypt some packets, not
> others, require verification from some networks, not others,...), and
> flexibility that the Linux network stack has, and ...

Exactly.  I just don't see TOE as a viable option for
networking, so I'm not too worried about not supporting
it.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

