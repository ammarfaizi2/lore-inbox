Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbULNHPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbULNHPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbULNHPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:15:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:58544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261437AbULNHPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:15:07 -0500
Date: Mon, 13 Dec 2004 23:14:56 -0800
From: Greg KH <greg@kroah.com>
To: Bill Chimiak <bchimiak@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: visor.ko freezes on dlpsh list
Message-ID: <20041214071456.GA10906@kroah.com>
References: <200412132119.52402.bchimiak@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412132119.52402.bchimiak@earthlink.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 09:19:52PM -0500, Bill Chimiak wrote:
> Summary: Handspring visor does not  fully sync with kpilot or jpilot
> or with pilot-xfer.
> With dlpsh, the user, and df work but it freezes with a ls command
> after completing about 75% to 80% of the actually listing.

What kernel version are you using?

thanks,

greg k-h
