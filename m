Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275138AbRIYRy7>; Tue, 25 Sep 2001 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275139AbRIYRyu>; Tue, 25 Sep 2001 13:54:50 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:46090 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275138AbRIYRyj>;
	Tue, 25 Sep 2001 13:54:39 -0400
Date: Tue, 25 Sep 2001 10:50:34 -0700
From: Greg KH <greg@kroah.com>
To: Stanislav Brabec <utx@penguin.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usbnet.c - patch to support GL620USB-A chip
Message-ID: <20010925105034.A13870@kroah.com>
In-Reply-To: <20010925184017.A401@utx.vol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925184017.A401@utx.vol.cz>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 06:40:17PM +0200, Stanislav Brabec wrote:
> Hallo,
> 
> there is a patch to support GeneSys Logic GL620USB-A chip, which can be
> found in GeneLink cables. I have obtained the driver code from David
> Brownell, the code comes from Jiun-Jie Huang (Genesys Logic Taiwan) and
> I have merged it with linux-2.4.10.

Please send this to the current maintainer of this driver
<dbrownell@users.sourceforge.net>

thanks,

greg k-h
