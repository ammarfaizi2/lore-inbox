Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSKZXaK>; Tue, 26 Nov 2002 18:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSKZXaJ>; Tue, 26 Nov 2002 18:30:09 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3602 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263215AbSKZXaI>;
	Tue, 26 Nov 2002 18:30:08 -0500
Date: Tue, 26 Nov 2002 15:29:34 -0800
From: Greg KH <greg@kroah.com>
To: Romain Lievin <rlievin@free.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@verizon.net>
Subject: Re: Fwd: [PATCH] tiglusb timeouts
Message-ID: <20021126232934.GF613@kroah.com>
References: <20021126203918.GA4186@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126203918.GA4186@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 09:39:18PM +0100, Romain Lievin wrote:
> Hi,
> 
> this patch fixes some troubles in the tiglusb driver.
> 
> Patch is against 2.5.49. Please apply.

I also applied it to my 2.4 tree, as it applied there too.

thanks,

greg k-h
