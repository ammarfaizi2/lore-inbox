Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSDKSBl>; Thu, 11 Apr 2002 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312706AbSDKSBk>; Thu, 11 Apr 2002 14:01:40 -0400
Received: from www.transvirtual.com ([206.14.214.140]:62734 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S312704AbSDKSBj>; Thu, 11 Apr 2002 14:01:39 -0400
Date: Thu, 11 Apr 2002 11:01:26 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "John P. Looney" <john@antefacto.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <20020411174941.GC17962@antefacto.com>
Message-ID: <Pine.LNX.4.10.10204111100520.25060-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I'd presumed this was
> > > the whole point of the busid spec in the config file.
> > No, it's for running one Xserver on multiple displays at once only.
> > Sad, ain't it?
> 
>  Very sad. Nice to know it's not really the kernel's fault. 
> 
>  Is it possible to say "Any mice plugged in to this port is
> /dev/input/mouse3" etc. so that if someone plugged out your mouse, plugged
> in another into a different port, and you plugged yours back in, that they
> wouldn't renumberate ?

Enable Hotplug :-) The input layer supports it!!

