Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbUKQXRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbUKQXRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUKQXPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:15:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52682 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262669AbUKQXOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:14:11 -0500
Date: Wed, 17 Nov 2004 15:13:57 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Message-ID: <20041117231357.GA20701@kroah.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411171932.47163.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171932.47163.andrew@walrond.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 07:32:47PM +0000, Andrew Walrond wrote:
> I noticed that when upgrading from 2.6.8.1 to rc2, start_udev now takes 10-15s 
> after printing
> 
> "Creating initial udev device nodes:"
> 
> Any known reason? should I upgrade udev? (030 installed)

Well, 045 is the latest version, so 030 is a bit old :)

thanks,

greg k-h
