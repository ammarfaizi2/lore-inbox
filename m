Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbUKJTgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUKJTgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUKJTgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:36:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:11203 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262112AbUKJTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:35:36 -0500
Date: Wed, 10 Nov 2004 11:35:18 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, sundarapandian.durairaj@intel.com,
       tom.l.nguyen@intel.com, willy@debian.org
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041110193518.GA2632@kroah.com>
References: <200411101938.iAAJcwNU030100@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411101938.iAAJcwNU030100@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 11:38:58AM -0800, long wrote:
> On Wed, Nov 10, 2004 at 9:36 Greg KH wrote:
> > Your patch is line wrapped, and mime encoded.
> 
> On behalf of Sundar, I redo it.
> Signed-off-by: Sundarapandian Durairaj

You didn't do it in the proper format :)

Please read Documentation/SubmittingPatches.

Also, I don't think you can add a "Signed-off-by:" on behaf of someone
else, sorry.

And you forgot the full patch information in the body of the message.

We'll get there eventually...

thanks,

greg k-h
