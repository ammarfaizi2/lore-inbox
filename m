Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbUKPF60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUKPF60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUKPF5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:57:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:46043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261909AbUKPFze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:55:34 -0500
Date: Mon, 15 Nov 2004 21:44:35 -0800
From: Greg KH <greg@kroah.com>
To: ambx1@neo.rr.com, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, matthieu castet <castet.matthieu@free.fr>,
       bjorn.helgaas@hp.com, vojtech@suse.cz,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] PNP support for i8042 driver
Message-ID: <20041116054435.GD29328@kroah.com>
References: <41960AE9.8090409@free.fr> <200411140148.02811.dtor_core@ameritech.net> <20041116053741.GD29574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116053741.GD29574@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 12:37:41AM -0500, Adam Belay wrote:
> 
> As a general convention, I think we do.  This should apply to every bus and
> driver.  Every hardware component should have a driver bound to it.

I agree too, for the very reasons you list.

</aol>

greg k-h
