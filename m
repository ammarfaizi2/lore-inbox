Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270542AbTGNGMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270544AbTGNGMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:12:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:63117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270542AbTGNGMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:12:44 -0400
Date: Sun, 13 Jul 2003 23:27:29 -0700
From: Greg KH <greg@kroah.com>
To: Dely Sy <dlsy@unix-os.sc.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 1/4 PCI Hot-plug driver patch for 2.5.74 kernel
Message-ID: <20030714062729.GB20482@kroah.com>
References: <200307121609.h6CG9ld28328@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307121609.h6CG9ld28328@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 09:09:47AM -0700, Dely Sy wrote:
> This patch was sent out to this and pcihpd-discuss mailing lists on
> 7/10.  However, it didn't show up on this mailing list most probably
> due to the message size.  Now I make it into 4 parts and resend them.
> There were already a few discussions on this patch.

Hm, this just split the patch up along file diffs?  Did you change
anything from the one big patch you send me earlier?

thanks,

greg k-h
