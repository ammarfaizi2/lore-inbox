Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbTEFXbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 19:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbTEFXbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 19:31:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:27591 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261189AbTEFXbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 19:31:17 -0400
Date: Tue, 6 May 2003 16:45:15 -0700
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHES] USB input layer improvements
Message-ID: <20030506234515.GA4117@kroah.com>
References: <20030506002233.GY679@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506002233.GY679@phunnypharm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:22:33PM -0400, Ben Collins wrote:
> 
> Obviously that doesn't work right. I'm not sure what the correct thing
> to do is, so my patch for this is only RFC status. With this patch my
> mouse and keyboard still work, and the joysticks work correctly. Maybe
> the correct thing is to map the physical values read from the device to
> the logical values.

Your patch looks sane at first glance, but Vojtech needs to verify that
this is ok before I can apply it.

thanks,

greg k-h
