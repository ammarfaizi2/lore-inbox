Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTHSU6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTHSU5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:57:33 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:44997 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261451AbTHSU5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:57:06 -0400
Subject: Re: Can't read fan-speeds from i2c
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030819205356.GA5968@kroah.com>
References: <1061324213.708.6.camel@chevrolet.hybel>
	 <20030819205356.GA5968@kroah.com>
Content-Type: text/plain
Message-Id: <1061326633.611.8.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 22:57:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 19.08.2003 kl. 22.53 skrev Greg KH:
> On Tue, Aug 19, 2003 at 10:16:53PM +0200, Stian Jordet wrote:
> > Hi,
> > 
> > I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> > seems to work as it is supposed to, except for fan-speeds. They say 0.
> > Is that supposed behaviour since the as99127f doesn't have any
> > datasheets, or am I doing something wrong?
> 
> What kernel version are you using?

Latest bk-snapshot...

Best regards,
Stian

