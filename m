Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbULGXZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbULGXZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbULGXZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:25:19 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2470 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261951AbULGXZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:25:16 -0500
Date: Tue, 7 Dec 2004 11:39:15 -0800
From: Greg KH <greg@kroah.com>
To: jonathan li <spiderium@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb does not work on via's smp mainboard
Message-ID: <20041207193915.GA26208@kroah.com>
References: <14dd4ead041206215713fd1646@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dd4ead041206215713fd1646@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 01:57:14PM +0800, jonathan li wrote:
> hi, all
> I installed kernel 2.4.21 on an via's mainboard, it seems that the usb
> host controller does not work. when a connect my flash disk to it,it
> reports the messages as follows:

Can you try a newer, 2.4 or even 2.6 kernel?  This is probably an
interrupt routing issue that should be fixed in a newer kernel.

thanks,

greg k-h
