Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314649AbSDTQWK>; Sat, 20 Apr 2002 12:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314650AbSDTQWJ>; Sat, 20 Apr 2002 12:22:09 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:18185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314649AbSDTQWI>;
	Sat, 20 Apr 2002 12:22:08 -0400
Date: Sat, 20 Apr 2002 08:20:41 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 usb(?) oops
Message-ID: <20020420152041.GA17327@kroah.com>
In-Reply-To: <200204201533.50375.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 23 Mar 2002 12:53:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 03:33:50PM +0200, Oliver Feiler wrote:
> Hi,
> 
> This oops occurs everytime I use kpilot to hotsync my Handpsring Visor.

As per the archives, use this patch to fix this problem:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=101735261202744

thanks,

greg k-h
