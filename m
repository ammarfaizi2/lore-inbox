Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVCDHzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVCDHzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCDHzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:55:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16106 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262603AbVCDHzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:55:32 -0500
Message-ID: <42281465.6070605@pobox.com>
Date: Fri, 04 Mar 2005 02:55:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jochen Striepe <jochen@tolot.escape.de>, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <20050302205826.523b9144.davem@davemloft.net>	<4226C235.1070609@pobox.com>	<20050303080459.GA29235@kroah.com>	<4226CA7E.4090905@pobox.com>	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>	<422751C1.7030607@pobox.com>	<20050303181122.GB12103@kroah.com>	<20050303151752.00527ae7.akpm@osdl.org>	<20050303234523.GS8880@opteron.random>	<20050303160330.5db86db7.akpm@osdl.org>	<20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org>
In-Reply-To: <20050303213005.59a30ae6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It won't help that at all.  None of these proposals will increase testing
> of tip-of-tree.  In fact the 2.6.x proposal may decrease that level of
> that testing, although probably not much.

Giving humans a well-known point where bugfixes-only mode starts would 
help.  Such as the -pre/-rc split does in 2.4.x.

	Jeff


