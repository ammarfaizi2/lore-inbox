Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVDZUMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVDZUMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVDZUMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:12:12 -0400
Received: from gate.in-addr.de ([212.8.193.158]:34221 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261767AbVDZUMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:12:03 -0400
Date: Tue, 26 Apr 2005 22:09:48 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>, Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
Message-ID: <20050426200948.GP7859@marowsky-bree.de>
References: <426E62ED.5090803@quadrics.com> <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost> <1114535584.5410.2.camel@mindpipe> <Pine.LNX.4.62.0504261918210.2071@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504261918210.2071@dragon.hyggekrogen.localhost>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-26T19:20:13, Jesper Juhl <juhl-lkml@dif.dk> wrote:

> I don't know what you do, but when I'm grep'ing the tree for some function 
> I'm often looking for its return type, having that on the same line as the 
> function name lets me grep for the function name and the grep output will 
> contain the return type and function name nicely on the same line.

grep -rB1 '^function' drivers/



