Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbUAKEMi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 23:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUAKEMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 23:12:38 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:9236 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265753AbUAKEMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 23:12:37 -0500
Date: Sat, 10 Jan 2004 23:12:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <sim@netnation.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.24 SMP lockups
In-Reply-To: <20040110144049.5e195ebd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0401102311310.14466-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Andrew Morton wrote:

> We don't have an each-CPU backtrace facility - it could be handy.  
> There's one in the low-latency patch for some reason.

There's one in the RHEL3 tree, too.

Marcelo, do you want me to rediff it and send it to you ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

