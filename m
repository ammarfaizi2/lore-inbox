Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSEXNuP>; Fri, 24 May 2002 09:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSEXNuO>; Fri, 24 May 2002 09:50:14 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13746 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314379AbSEXNuN>;
	Fri, 24 May 2002 09:50:13 -0400
Date: Thu, 23 May 2002 00:22:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hayden James <hjames@stevens-tech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nVidia NIC/IDE/something support?
Message-ID: <20020523002211.A1853@ucw.cz>
In-Reply-To: <Pine.SGI.4.30.0205221316500.3534318-100000@attila.stevens-tech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 01:20:28PM -0400, Hayden James wrote:
> The asus board uses the realtek 8139 as the onboard nic and should be
> supported by the linux kernel.  The audio seems to be an exact clone of
> the i810 driver with just same name changes and added pci ids, you can
> get the gpl patches for it at nvidia's web site.  The rest of the
> facilities, ide,

nVidia nForce IDE is supported only in 2.5 at the moment. 2.5 also
supports it's sounds without any modifications. USB is a standard OHCI
there, so no problem.

> usb etc should be supported normally by the linux kernel.
> Also you will need to get the separate nVidia video driver for graphics
> support.
> 
> Hayden A. James
> Computer Engineering
> Stevens Institute of Technology
> http://attila.stevens-tech.edu/~hjames/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
