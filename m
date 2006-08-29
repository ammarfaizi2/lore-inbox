Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWH2QJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWH2QJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWH2QJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:09:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:48016 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964960AbWH2QJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:09:54 -0400
Date: Tue, 29 Aug 2006 09:08:41 -0700
From: Greg KH <gregkh@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Greg KH <greg@kroah.com>, "Luck, Tony" <tony.luck@intel.com>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>, akpm@osdl.org,
       dev@openvz.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net, stable@kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, xemul@openvz.org
Subject: Re: [stable] [PATCH] Linux 2.6.17.11 - fix compilation error on IA64 (try #3)
Message-ID: <20060829160841.GB9078@suse.de>
References: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com> <20060829013137.GA27869@kroah.com> <44F431F5.7020703@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F431F5.7020703@sw.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 04:24:21PM +0400, Kirill Korotaev wrote:
> Probably it is my fault, since I thought that patches which got into -stable
> automatically go into Linus tree.

No they do not.  Usually it's the requirement that they be in his tree
first, but I didn't think it was necessary this time due to my
misunderstanding about the fix.

thanks,

greg k-h
