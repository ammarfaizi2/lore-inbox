Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUFBRdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUFBRdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUFBRdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:33:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:57564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263702AbUFBRdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:33:05 -0400
Date: Wed, 2 Jun 2004 09:49:12 -0700
From: Greg KH <greg@kroah.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB interrupt is turned off after periods of inactivity
Message-ID: <20040602164912.GB7829@kroah.com>
References: <40BD869F.402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BD869F.402@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:49:51PM +1000, Nick Piggin wrote:
> Hello. I sent this to the USB devel list. No activity.
> Let me know if I can get you more info or test anything.

You didn't get a response probably because you are using the nvidia
driver, and no kernel developer can help you then, sorry.

Try reproducing it without that driver loaded.

greg k-h
