Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVCIAeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVCIAeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVCHXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:46:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:36741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262238AbVCHXh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:37:59 -0500
Date: Tue, 8 Mar 2005 15:37:43 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       khali@linux-fr.org
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
Message-ID: <20050308233743.GB11454@kroah.com>
References: <11099696383203@kroah.com> <11099696391236@kroah.com> <422E24A8.4070504@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422E24A8.4070504@tmr.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 05:18:16PM -0500, Bill Davidsen wrote:
> Greg KH wrote:
> >ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org
> >
> >[PATCH] PCI: One more Asus SMBus quirk
> >
> >One more Asus laptop requiring the SMBus quirk (W1N model).
> >
> >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Hopefully this and the double-free patch will be included in 2.6.11.n+1? 

what double-free patch?

thanks,

greg k-h
