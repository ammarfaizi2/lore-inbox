Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317783AbSFMRhC>; Thu, 13 Jun 2002 13:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSFMRhB>; Thu, 13 Jun 2002 13:37:01 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:13583 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317783AbSFMRhA>;
	Thu, 13 Jun 2002 13:37:00 -0400
Date: Thu, 13 Jun 2002 10:36:55 -0700
From: Greg KH <greg@kroah.com>
To: Martin Knoblauch <knobi@knobisoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Problems with 2.4.19-pre10-ac2
Message-ID: <20020613173655.GD21644@kroah.com>
In-Reply-To: <200206131916.16214.knobi@knobisoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 16 May 2002 15:59:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 07:16:16PM +0200, Martin Knoblauch wrote:
>  Suspicious are the "usb_control/bulk_msg: timeout" messages and the "not 
> accepting" stuff. Same happens with the uhci.o module. The camera works with 
> the 2.4.18-4GB kernel from SuSE8.0. So I suspect some problems with 
> 2.4.19-pre10-ac2. Unfortunatelly I cannot build 2.4.19-pre10 alone, due to 
> compilation errors.

What compilation errors?  USB specific ones?

I would be very interested to see if this proble also happens on
2.4.19-pre10.

thanks,

greg k-h
