Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSLNQZE>; Sat, 14 Dec 2002 11:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbSLNQZE>; Sat, 14 Dec 2002 11:25:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4359 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265649AbSLNQZE>;
	Sat, 14 Dec 2002 11:25:04 -0500
Date: Sat, 14 Dec 2002 08:31:03 -0800
From: Greg KH <greg@kroah.com>
To: Frank Jacobberger <f1j1@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ehci-hcd.o apparent load failure in 2.4.20-xx.. but
Message-ID: <20021214163103.GA451@kroah.com>
References: <3DFAE241.7060603@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFAE241.7060603@xmission.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 12:48:17AM -0700, Frank Jacobberger wrote:
> Who maintains this driver?

Look in MAINTAINERS and in the driver source, the name is there :)

> I'm getting an odd error when kernel boots that the ehci-hcd.o.gz can't 
> load..

See this thread on linux-usb-devel:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103987299402874&w=2

Which should get you going again for this specific Intel device.

Hope this helps,

greg k-h
