Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSLZRpw>; Thu, 26 Dec 2002 12:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLZRpw>; Thu, 26 Dec 2002 12:45:52 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36101 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263291AbSLZRpw>;
	Thu, 26 Dec 2002 12:45:52 -0500
Date: Thu, 26 Dec 2002 09:49:59 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?J=F6rg?= Prante <joergprante@netcologne.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Message-ID: <20021226174958.GB8229@kroah.com>
References: <200212260133.54856.joergprante@netcologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200212260133.54856.joergprante@netcologne.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 01:33:54AM +0100, Jörg Prante wrote:
> 029_driver-usbd-net
> 030_driver-usbd-net-fix

I'm pretty sure these drivers aren't needed anymore, as the usbnet
driver should work for the devices that usbd previously supported.

thanks,

greg k-h
