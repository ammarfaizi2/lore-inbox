Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbSJMWt5>; Sun, 13 Oct 2002 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261764AbSJMWt5>; Sun, 13 Oct 2002 18:49:57 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:43462 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261763AbSJMWt4>; Sun, 13 Oct 2002 18:49:56 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 14 Oct 2002 08:55:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15785.63957.167015.415347@notabene.cse.unsw.edu.au>
Cc: okir@monad.swb.de, nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.42/net/sunrpc/sunrpc_syms.c - symbols needed by new nfsd
In-Reply-To: message from Adam J. Richter on Sunday October 13
References: <20021013112452.A286@baldur.yggdrasil.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 13, adam@yggdrasil.com wrote:
> 	nfsd in 2.5.42 needs a bunch of symbols that the sunrpc module
> does not export.  This patch adds them to net/sunrpc/sunrpc_syms.c.
> I am now running the nfsd and sunrpc modules based on this patch.

Thanks.  A similar patch has been sent to Linus and hopefully will
appear in bk soon...

NeilBrown
