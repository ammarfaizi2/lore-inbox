Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUBXAhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUBXAhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:37:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:27605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262101AbUBXAhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:37:40 -0500
Date: Mon, 23 Feb 2004 16:27:34 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Another oops in i2c-core with debug
Message-ID: <20040224002734.GF24225@kroah.com>
References: <20040222132611.57e9faa7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222132611.57e9faa7.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 01:26:11PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Some times ago, you fixed an oops in i2c-core when debugging is enabled:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107585749612115&w=2
> 
> Looks like you missed that second one:

Applied, thanks.

greg k-h
