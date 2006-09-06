Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWIFS1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWIFS1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWIFS1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:27:37 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:4056 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751501AbWIFS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:27:34 -0400
Date: Wed, 6 Sep 2006 12:27:33 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060906182733.GJ2558@parisc-linux.org>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 11:24:05AM -0700, Linus Torvalds wrote:
> If MIPS and parisc don't matter for the stable tree (very possible - there 
> are no big commercial distributions for them), then dammit, neither should 
> ia64 and sparc (there are no big commercial distros for them either). 

Erm, RHEL and SLES both support ia64.
