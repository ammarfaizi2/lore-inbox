Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267402AbUHPDiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbUHPDiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUHPDiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:38:07 -0400
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:16243 "HELO
	boetes.org") by vger.kernel.org with SMTP id S267409AbUHPDh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:37:27 -0400
Date: Mon, 16 Aug 2004 05:37:26 +0200
From: Han Boetes <han@mijncomputer.nl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040816033748.GF6641@boetes.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 14 Aug 2004, Christoph Hellwig wrote:
> > Can we make this 2.6.9 to avoid breaking all kinds of scripts
> > expecting three-digit kernel versions?
>
> Well, we've been discussing the 2.6.x.y format for a while, so I see
> this as an opportunity to actually do it... Will it break automated
> scripts? Maybe. But on the other hand, we'll never even find out
> unless we try it some time.

install_latest_kernel works fine with 2.6.8.1 :-)



# Han
--
http://freshmeat.net/install_latest_kernel
