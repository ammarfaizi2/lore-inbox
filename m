Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136544AbRD3Xby>; Mon, 30 Apr 2001 19:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136547AbRD3Xbo>; Mon, 30 Apr 2001 19:31:44 -0400
Received: from jalon.able.es ([212.97.163.2]:455 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136544AbRD3Xb1>;
	Mon, 30 Apr 2001 19:31:27 -0400
Date: Tue, 1 May 2001 01:31:20 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [PATCH] automatic multi-part link rules (fwd)
Message-ID: <20010501013120.A15120@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0105010022020.24511-100000@vaio> <16302.988670989@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <16302.988670989@ocs3.ocs-net>; from kaos@ocs.com.au on Tue, May 01, 2001 at 00:49:49 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.01 Keith Owens wrote:
> 
> The patch appears to work but is it worth applying now?  The existing
> 2.4 rules work fine and the entire kbuild system will be rewritten for
> 2.5, including the case you identified here.  It struck me as a decent
> change but for no benefit and, given that the 2.4 kbuild system is so
> fragile, why not live with something we know works until 2.5 is
> available?
> 

We will have to live with 2.4 until 2.6, 'cause 2.5 will not be stable.
2.4 will be the stable and non "brain damaged" kernel in distros.
So every thing that can make 2.4 more clean, better. Think in 2.4.57,
and we still are in 4. And feature backports, and new drivers...
The 2.5 rewrite is not excuse. The knowledge on the actual state, yes.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4 #1 SMP Sat Apr 28 11:45:02 CEST 2001 i686

