Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVJNLrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVJNLrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 07:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVJNLrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 07:47:35 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:47825 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750716AbVJNLre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 07:47:34 -0400
Date: Fri, 14 Oct 2005 05:47:22 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>,
       Ralf Baechle <ralf@linux-mips.org>,
       Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@karaya.com>
Subject: Re: [PATCH 11/14] Big kfree NULL check cleanup - arch
Message-ID: <20051014114722.GB16113@parisc-linux.org>
References: <200510132129.40176.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510132129.40176.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 09:29:39PM +0200, Jesper Juhl wrote:
> This is the arch/ part of the big kfree cleanup patch.

Ignore the parisc part; it conflicts with simply deleting that code
(patch from hch).
