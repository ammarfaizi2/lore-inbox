Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSEUXjm>; Tue, 21 May 2002 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316787AbSEUXjl>; Tue, 21 May 2002 19:39:41 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:42502 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316783AbSEUXjj>;
	Tue, 21 May 2002 19:39:39 -0400
Date: Tue, 21 May 2002 16:38:35 -0700
From: Greg KH <greg@kroah.com>
To: "Svein E. Seldal" <Svein.Seldal@edcom.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Custom kernel version and depmod
Message-ID: <20020521233835.GB4221@kroah.com>
In-Reply-To: <20020521180515.GF1295@kroah.com> <KKEHJJLHENOALGODMOGLAECICBAA.Svein.Seldal@edcom.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 23 Apr 2002 21:58:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 01:30:36AM +0200, Svein E. Seldal wrote:
> 
> 
> > From: Greg KH
> >
> > A bit off-topic, but any reason why you can not just submit your driver
> > for inclusion in the main kernel tree?  The USB developers are usually
> > quite easy to convince to take new drivers :)
> 
> Well I know, but the problem here is that the design is to a development
> card. It has not been assigned a VID/PID and neither will it. I dont think
> we should clutter the kernel with such drivers, do we?

Hasn't stopped us in the past :)

> Anyway, my question was focused on depmod and kernel module version system
> and not the driver itself.

True, hence my message started with "A bit off-topic..."

thanks,

greg k-h
