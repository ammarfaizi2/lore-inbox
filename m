Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbUDYDnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUDYDnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 23:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUDYDnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 23:43:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:54977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262890AbUDYDnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 23:43:04 -0400
Date: Sat, 24 Apr 2004 20:42:39 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Weber <and_weber_and@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb_storage flash drive (NOKIA 5510) not working anymore in Linux 2.6
Message-ID: <20040425034239.GA14209@kroah.com>
References: <1210477013@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1210477013@web.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2004 at 05:31:55PM +0200, Andreas Weber wrote:
> Hi,
> syncing/umount of the NOKIA 5510 mobile phone doesn't work with kernel 2.6 (last
> tested with 2.6.6-rc2-mm1 and all USB fixes for 2.6.6-rc2 applied.)

Should be fixed now in the latest -bk tree.  Can you verify this?  Or
wait for the next -rc release.

thanks,

greg k-h
