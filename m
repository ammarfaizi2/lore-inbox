Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265286AbUFOEtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbUFOEtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 00:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUFOEtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 00:49:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:55480 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265286AbUFOEtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 00:49:53 -0400
Date: Mon, 14 Jun 2004 21:48:06 -0700
From: Greg KH <greg@kroah.com>
To: Chris Friesen <chris_friesen@sympatico.ca>
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [BUG]  problem with usb-storage
Message-ID: <20040615044806.GA10354@kroah.com>
References: <40CE7E28.4090707@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CE7E28.4090707@sympatico.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 12:42:16AM -0400, Chris Friesen wrote:
> I'm running an x86 version of 2.6.5, attempting to use a lexar CF memory
> card with the Jumpshot card reader.

Can you try 2.6.7-rc3?  Or at least 2.6.6?

thanks,

greg k-h
