Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVDHAKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVDHAKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDHAKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:10:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:56813 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262629AbVDHAKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:10:37 -0400
Date: Thu, 7 Apr 2005 17:10:12 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][26.5/27] Add MT25204 PCI IDs
Message-ID: <20050408001011.GB7010@kroah.com>
References: <2005411249.RHQWyM8AFcqb1PM4@topspin.com> <52hdiqi22t.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52hdiqi22t.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 02:06:50PM -0800, Roland Dreier wrote:
> Ugh, this patch is required to build support for the new Mellanox
> HCAs.  Greg K-H applied it to his tree a while ago but it hasn't made
> it to Linus yet.
> 
> Sorry,
>   Roland
> 
> Add PCI device IDs for new Mellanox MT25204 "Sinai" InfiniHost III Lx HCA.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

Already in 2.6.12-rc2.

thanks,

greg k-h
