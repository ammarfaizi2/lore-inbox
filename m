Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285532AbRLSVqB>; Wed, 19 Dec 2001 16:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285534AbRLSVpw>; Wed, 19 Dec 2001 16:45:52 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:55054 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285533AbRLSVpe>;
	Wed, 19 Dec 2001 16:45:34 -0500
Date: Wed, 19 Dec 2001 13:42:11 -0800
From: Greg KH <greg@kroah.com>
To: Flavio Stanchina <flavio.stanchina@tin.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc2 oopses when unloading hid.o
Message-ID: <20011219134211.E11961@kroah.com>
In-Reply-To: <20011219200605.ISMI15319.fep23-svc.tin.it@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219200605.ISMI15319.fep23-svc.tin.it@there>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 21 Nov 2001 18:48:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:06:05PM +0100, Flavio Stanchina wrote:
> Please CC me, I'm currently not on the list due to lack of time.
> 
> I've got two oopses when I unloaded the drivers/usb/hid.o module
> ('rmmod hid'). Here's the first:

Can you run them through ksymoops for us?

thanks,

greg k-h
