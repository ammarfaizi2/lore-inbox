Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTD2Vui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTD2Vuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:50:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27900 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261873AbTD2Vuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:50:37 -0400
Date: Tue, 29 Apr 2003 15:04:49 -0700
From: Greg KH <greg@kroah.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030429220449.GA9058@kroah.com>
References: <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429144842.10c95000@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030429144842.10c95000@unixmail.qualcomm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 02:55:17PM -0700, Max Krasnyansky wrote:
> >Ok, that works for me.  Does the patch below work out for you?
> Yep. I'd make it return void though.

Good point, I'll change that and send it off.

thanks,

greg k-h
