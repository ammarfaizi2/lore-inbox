Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSBEGCT>; Tue, 5 Feb 2002 01:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSBEGCI>; Tue, 5 Feb 2002 01:02:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:34052 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288748AbSBEGBx>;
	Tue, 5 Feb 2002 01:01:53 -0500
Date: Mon, 4 Feb 2002 21:59:33 -0800
From: Greg KH <greg@kroah.com>
To: lk@Aniela.EU.ORG
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there any support in kernel for micronet sp907 v3 ?
Message-ID: <20020205055933.GI31025@kroah.com>
In-Reply-To: <20020204211434.A3214@NS1.Aniela.EU.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020204211434.A3214@NS1.Aniela.EU.ORG>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 08 Jan 2002 02:46:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 09:14:34PM +0200, lk@Aniela.EU.ORG wrote:
> 
> 
> Hi,
> 
> 
> I have an USB wireless adapter made by Micronet. 
> Model name is SP907 V3.
> 
> It is an USB device that has one PCMCIA slot that hosts the wireless 
> adapter. The USB device acts like a host for the PCMCIA card. Is there any 
> support in Linux for such wireless network adapter ?

Please check the list of supported USB devices on Linux from the link
at:
	http://www.linux-usb.org/

If you are unsure after reading the list, post the results of
/proc/bus/usb/devices with the device plugged in to the linux-usb-users
list.

thanks,

greg k-h
