Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWHUSZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWHUSZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWHUSZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:25:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:38785 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932117AbWHUSZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:25:55 -0400
Date: Mon, 21 Aug 2006 11:24:08 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: stable@kernel.org, bunk@stusta.de, maks@sternwelten.at,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH] [SERIAL] icom: select FW_LOADER
Message-ID: <20060821182408.GD17295@kroah.com>
References: <20060816175350.GA9888@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816175350.GA9888@aepfle.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:53:50PM +0200, Olaf Hering wrote:
> 
> The icom driver uses request_firmware()
> and thus needs to select FW_LOADER.
> 
> Signed-off-by: maximilian attems <maks@sternwelten.at>
> Signed-off-by: Olaf Hering <olh@suse.de>

Queued to -stable, thanks.

greg k-h
