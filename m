Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289238AbSAGP7I>; Mon, 7 Jan 2002 10:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSAGP67>; Mon, 7 Jan 2002 10:58:59 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:42762 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289238AbSAGP6t>;
	Mon, 7 Jan 2002 10:58:49 -0500
Date: Mon, 7 Jan 2002 07:56:54 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Missing entries in Configuure.help)
Message-ID: <20020107155654.GA6810@kroah.com>
In-Reply-To: <20020106210233.A30319@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020106210233.A30319@thyrsus.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 13:51:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 09:02:33PM -0500, Eric S. Raymond wrote:
> The following symbols (mostly ARM port stuff) are missing enntries in
> Configure.help.  Please contribute help entries if you can.

You might want to state which kernel version you are referring to.

> USB_EHCI_HCD
> USB_SERIAL_IPAQ
> USB_SERIAL_KLSI
> USB_STV680
> USB_VICAM

All of these are present in 2.5.2-pre7, 2 kernel versions ago :)

thanks,

greg k-h
