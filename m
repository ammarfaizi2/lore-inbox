Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSFKRfH>; Tue, 11 Jun 2002 13:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSFKRfG>; Tue, 11 Jun 2002 13:35:06 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:10762 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317211AbSFKRfG>;
	Tue, 11 Jun 2002 13:35:06 -0400
Date: Tue, 11 Jun 2002 10:31:17 -0700
From: Greg KH <greg@kroah.com>
To: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels hang before uncompressing
Message-ID: <20020611173117.GA9756@kroah.com>
In-Reply-To: <200206111436.g5BEa4Z17577@drtalus.aoe.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 14 May 2002 16:21:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 10:36:04AM -0400, Cengiz Akinli wrote:
>   The hardware I need to be able to use is a multi-port USB-to-serial
> convertor.  And this is only directly supported in 2.4.x kernels.

Which USB device is this?  I've backported almost all of the usb-serial
drivers to the latest 2.2.21 kernel.

thanks,

greg k-h
