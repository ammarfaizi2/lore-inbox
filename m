Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265834AbUEZWXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUEZWXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUEZWXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:23:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5270
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265834AbUEZWXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:23:45 -0400
Date: Thu, 27 May 2004 00:23:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040526222340.GT29378@dualathlon.random>
References: <20040204.204058.1025214600.nomura@linux.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0402051834070.1396-100000@localhost.localdomain> <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <20040526124104.GF6439@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526124104.GF6439@logos.cnet>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 09:41:04AM -0300, Marcelo Tosatti wrote:
> Andrea, Hugh, Jun'ichi,
> 
> I think we can merge this patch.
> 
> Its very safe - default behaviour unchanged. 

agreed. And from a stability standpoint it's very safe even when the
behaviour is changed with the non-default setting ;).

thanks.
