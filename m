Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVJNVbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVJNVbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVJNVbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:31:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:27027 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750932AbVJNVbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:31:05 -0400
Date: Fri, 14 Oct 2005 14:30:38 -0700
From: Greg KH <greg@kroah.com>
To: Robin Holt <holt@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com, Dave Hansen <haveblue@us.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051014213038.GA7450@kroah.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com> <20051014192225.GD14418@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014192225.GD14418@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 02:22:25PM -0500, Robin Holt wrote:
> +EXPORT_SYMBOL(get_one_pte_map);

EXPORT_SYMBOL_GPL() ?

thanks,

greg k-h
