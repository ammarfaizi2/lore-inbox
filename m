Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUK2Xr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUK2Xr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUK2Xrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:47:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18332 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261862AbUK2Xry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:47:54 -0500
Date: Mon, 29 Nov 2004 15:42:35 -0800
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] I2C: macintoch/therm_* drivers cleanups
Message-ID: <20041129234235.GA21496@kroah.com>
References: <20041129231855.5e7f0bed.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129231855.5e7f0bed.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 11:18:55PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch cleans the macintoch/therm_* drivers a bit. It removes
> useless IDs, cleans names (no white space), some coding style fixes as
> well, etc. It's exactly the same as what I posted yesterday as a
> candidate fix to bug #3823:
> http://bugzilla.kernel.org/show_bug.cgi?id=3823
> 
> Although it isn't the proper fix for that bug, as you underlined, this
> still sounds like a sane set of cleanups for these drivers.
> 
> Please apply,

Applied, thanks,

greg k-h
