Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTAOXYe>; Wed, 15 Jan 2003 18:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTAOXYe>; Wed, 15 Jan 2003 18:24:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33804 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267396AbTAOXYd>;
	Wed, 15 Jan 2003 18:24:33 -0500
Date: Wed, 15 Jan 2003 15:33:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
Subject: Re: 2.4.20/2.4.21-pre3 usb Oops
Message-ID: <20030115233303.GA26255@kroah.com>
References: <20030115111234.GA1322@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115111234.GA1322@finwe.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 12:12:35PM +0100, Jacek Kawa wrote:
> Hello!
> 
> I've got ide disk connected as usb-storage device.
> 
> Oops is reproductable (output from ksymoops below). 
> I had to copy it from screen (I hope effects are 
> reliable).

Can you switch UHCI drivers and see if the problem is still there?

thanks,

greg k-h
