Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284360AbRLXCrY>; Sun, 23 Dec 2001 21:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284361AbRLXCrF>; Sun, 23 Dec 2001 21:47:05 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:50185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284360AbRLXCqy>;
	Sun, 23 Dec 2001 21:46:54 -0500
Date: Sun, 23 Dec 2001 18:42:43 -0800
From: Greg KH <greg@kroah.com>
To: Guido Guenther <guido.guenther@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17]: oops in usbcore during suspend
Message-ID: <20011223184243.D5941@kroah.com>
In-Reply-To: <20011223230723.GA1483@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011223230723.GA1483@bogon.ms20.nix>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 26 Nov 2001 00:09:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 12:07:23AM +0100, Guido Guenther wrote:
> Hi,
> when suspending my Omnibook XE3 (via Fn+F12) im seeing:

Can you run that oops through ksymoops?

And if you unload the usb modules before suspending, does the same
problem happen?

thanks,

greg k-h
