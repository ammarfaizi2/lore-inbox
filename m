Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVA1CbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVA1CbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVA1CbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:31:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4754 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261396AbVA1CbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:31:21 -0500
Message-ID: <41F9A3E7.5060607@pobox.com>
Date: Thu, 27 Jan 2005 21:31:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: netdev-2.6 queue updated
References: <41F980A0.8020905@pobox.com> <20050128021530.GB19150@hexapodia.org>
In-Reply-To: <20050128021530.GB19150@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> On Thu, Jan 27, 2005 at 07:00:32PM -0500, Jeff Garzik wrote:
> 
>>The attached changelog describes what I just pushed out to BitKeeper 
>>(and what should be appearing in the next -mm release from Andrew).
>>
>>Note to BK users:  please re-clone netdev-2.6, don't just 'bk pull'.
> 
> 
> It's much more efficient to do
> % bk undo -a`bk repogca`


Well, by "re-clone" I mean recreate.  It's probably better to do what I 
do, clone the latest linux-2.5 repo and the pull netdev-2.6 into that. 
Far less messy than 'bk undo'.

	Jeff



