Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWF2OU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWF2OU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWF2OU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:20:28 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:64655 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1750746AbWF2OU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:20:28 -0400
From: "amatus@ocgnet.org" <amatus@ocgnet.org>
Date: Thu, 29 Jun 2006 09:20:31 -0500
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI: Support registering for a command per-channel
Message-ID: <20060629142031.GA4995@login.ocgnet.org>
References: <20060623150705.GA14245@login.ocgnet.org> <449FF130.3010601@acm.org> <20060628192805.GA32766@login.ocgnet.org> <44A3277B.9060009@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A3277B.9060009@acm.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 08:06:03PM -0500, Corey Minyard wrote:
> This patch looks good to me.  I added the following as a header.
> Is this ok?  The "Signed-off-by" line is pretty important in patches.
> 
> Thanks,
> 
> -Corey
> --
> 
> This patch adds the ability to register for a command per-channel in
> the IPMI driver.
> 
> If your BMC supports multiple channels, incoming messages can be
> differentiated by the channel on which they arrived. In this case it's
> useful to have the ability to register to receive commands on a
> specific channel instead the current behaviour of all channels.
> 
> Signed-off-by: David Barksdale <amatus@ocgnet.org>
> 

Affirmative!
