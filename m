Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJMCFW>; Sat, 12 Oct 2002 22:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbSJMCFW>; Sat, 12 Oct 2002 22:05:22 -0400
Received: from f32.law8.hotmail.com ([216.33.241.32]:62480 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261430AbSJMCFU>;
	Sat, 12 Oct 2002 22:05:20 -0400
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: hahn@physics.mcmaster.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT400 & VT8235 support
Date: Sat, 12 Oct 2002 22:11:05 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F32VpMmOlbcrYP0QzBx00016e42@hotmail.com>
X-OriginalArrivalTime: 13 Oct 2002 02:11:05.0871 (UTC) FILETIME=[C98BE9F0:01C2725D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Mark Hahn <hahn@physics.mcmaster.ca>
>To: sean darcy <seandarcy@hotmail.com>
>Subject: Re: VIA KT400 & VT8235 support
>Date: Sat, 12 Oct 2002 17:34:42 -0400 (EDT)
>
> > Before spending money on a new VIA motherboard with the KT400 and VT8235
> > south bridge, I'd like to know if they're supported in 2.4 and 2.5. Are
> > they?
> >
> > Is there anyplace that lists supported chipsets, at least for 2,4?
>
>chipset vendors are astonishingly uninventive.  that one, for instance,
>is basically the same as the kt133.  to "support" one of these new spins,
>generally all that's required is adding its PCI ids to a few tables
>(for the ide controller, etc.)


Actually, I tried one tonight. It turns out that agpgart is not supported by 
2.4 or 2.5.

Do you mean I can just stick a PCI id (where do I find it?) in some table 
(filename?)? How?

thanks

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

