Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVCDINb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVCDINb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVCDINb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:13:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:5050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262163AbVCDIL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:11:29 -0500
Date: Fri, 4 Mar 2005 00:11:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jochen@tolot.escape.de, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304001103.195012a6.akpm@osdl.org>
In-Reply-To: <42281465.6070605@pobox.com>
References: <20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<20050303234523.GS8880@opteron.random>
	<20050303160330.5db86db7.akpm@osdl.org>
	<20050304025746.GD26085@tolot.miese-zwerge.org>
	<20050303213005.59a30ae6.akpm@osdl.org>
	<42281465.6070605@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
>  > It won't help that at all.  None of these proposals will increase testing
>  > of tip-of-tree.  In fact the 2.6.x proposal may decrease that level of
>  > that testing, although probably not much.
> 
>  Giving humans a well-known point where bugfixes-only mode starts would 
>  help.  Such as the -pre/-rc split does in 2.4.x.

Yup, sure.  I agree that we should be using Marcelo methodology on 2.6.x
release numbering.  Last time I mentioned it to Linus I didn't understand
the reply ;)


