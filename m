Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289877AbSBKRf0>; Mon, 11 Feb 2002 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSBKRfQ>; Mon, 11 Feb 2002 12:35:16 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:42244 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289865AbSBKRfH>;
	Mon, 11 Feb 2002 12:35:07 -0500
Date: Mon, 11 Feb 2002 09:31:34 -0800
From: Greg KH <greg@kroah.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4-pre6 -- debug.c:190: In function `usb_stor_print_Scsi_Cmnd': structure has no member named `address'
Message-ID: <20020211173134.GA11532@kroah.com>
In-Reply-To: <1013403908.30864.41.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013403908.30864.41.camel@turbulence.megapathdsl.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 14 Jan 2002 15:11:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2002 at 09:05:07PM -0800, Miles Lane wrote:
> CONFIG_USB_STORAGE_DEBUG=y

Change that item to =n and go bug the usb-storage author :)

thanks,

greg k-h
