Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRLKUWN>; Tue, 11 Dec 2001 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282924AbRLKUWD>; Tue, 11 Dec 2001 15:22:03 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:33796 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282945AbRLKUVs>;
	Tue, 11 Dec 2001 15:21:48 -0500
Date: Tue, 11 Dec 2001 12:19:55 -0800
From: Greg KH <greg@kroah.com>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: LKM <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Compilation errors on some usb file
Message-ID: <20011211121955.A807@kroah.com>
In-Reply-To: <1008100443.3236.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008100443.3236.0.camel@localhost.localdomain>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 13 Nov 2001 18:17:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 09:54:02PM +0200, Bongani Hlope wrote:
> Sorry about the first two patches they both apply on top
> of 2.4.17-pre7. I have attached both of them again I case ...

These patches do not make sense.  What kind of compile time errors do
you get that these fix?  And what is the .config file that you are using
to cause the errors?

thanks,

greg k-h
