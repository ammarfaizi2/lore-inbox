Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312148AbSCaSJ1>; Sun, 31 Mar 2002 13:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSCaSJH>; Sun, 31 Mar 2002 13:09:07 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:33551 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312148AbSCaSIr>;
	Sun, 31 Mar 2002 13:08:47 -0500
Date: Sun, 31 Mar 2002 10:08:00 -0800
From: Greg KH <greg@kroah.com>
To: roms@lpg.ticalc.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subject: kernel 2.5.7, tiusb: SilverLink cable driver for TI graphing calculators
Message-ID: <20020331180800.GE26801@kroah.com>
In-Reply-To: <3CA6E759.CE70B34D@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 03 Mar 2002 15:11:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 12:39:21PM +0200, Romain Liévin wrote:
> Hi,
> 
> this is a new driver for handling a TI-GRAPH LINK USB (aka SilverLink)
> cable 
> designed to connect a Texas Instruments graphing calculators to a 
> computer/workstation through USB.
> 
> This driver has an official device number.

Do you want to add this driver to the drivers/usb/ directory with the
rest of the kernel USB drivers?  If so, please send me a patch.

thanks,

greg k-h
