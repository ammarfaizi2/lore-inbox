Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSATW7F>; Sun, 20 Jan 2002 17:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSATW64>; Sun, 20 Jan 2002 17:58:56 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:32268 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287858AbSATW6w>;
	Sun, 20 Jan 2002 17:58:52 -0500
Date: Sun, 20 Jan 2002 14:54:23 -0800
From: Greg KH <greg@kroah.com>
To: lkml <linux-kernel@vger.kernel.org>,
        christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@ufies.org>
Subject: Re: usb-ohci, ov511, video4linux
Message-ID: <20020120225423.GA27088@kroah.com>
In-Reply-To: <20020120154119.GB2873@online.fr> <20020120162258.GC16166@sliepen.warande.net> <20020120170837.GD2873@online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020120170837.GD2873@online.fr>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 23 Dec 2001 19:50:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 12:08:37PM -0500, christophe barbé wrote:
> 
> The problem with the usb mouse is there with or without webcam.

Is there any kernel log messages when the mouse "goes away"?
It could be a flaky hub that is dropping the connection to your device,
or a flaky mouse.  I've seen both of these before.

thanks,

greg k-h
