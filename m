Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbVCXFhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVCXFhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVCXFhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:37:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58291 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263037AbVCXFgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:36:52 -0500
Message-ID: <424251E3.5060204@pobox.com>
Date: Thu, 24 Mar 2005 00:36:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Christoph Lameter <christoph@lameter.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Tina Yang <tinay@chelsio.com>,
       Scott Bardone <sbardone@chelsio.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [-mm patch] drivers/net/chelsio/osdep.h: small cleanups
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050324031026.GV1948@stusta.de> <Pine.LNX.4.58.0503231934430.11120@server.graphe.net> <42424ECB.4060807@osdl.org>
In-Reply-To: <42424ECB.4060807@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Christoph Lameter wrote:
> 
>> We just send an update to Andrew and Jeff that also fixes this issue.
>> Sadly that patch is >300k so we cannot post it to the list.
> 
> 
> you can post it to netdev@oss.sgi.com
> it doesn't seem to block large patches.


Well, it's still not kosher to send large patches.  Not everybody has 
broadband, you know :)  It clogs up archives and other stuff.

	Jeff


