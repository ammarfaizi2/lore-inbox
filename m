Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSANWhe>; Mon, 14 Jan 2002 17:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289110AbSANWha>; Mon, 14 Jan 2002 17:37:30 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:12813 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289102AbSANWgU>;
	Mon, 14 Jan 2002 17:36:20 -0500
Date: Mon, 14 Jan 2002 14:33:03 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <landley@trommello.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020114223302.GC22267@kroah.com>
In-Reply-To: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu> <20020114222101.ZPUW15906.femail44.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114222101.ZPUW15906.femail44.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 17 Dec 2001 20:00:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 09:19:01AM -0500, Rob Landley wrote:
> 
> The klibc source/binary debate still seems to be ongoing, but apart from 
> that, will the build process for initramfs be part of the kernel build or not?

I would vote for yes.  I would like this, if for no other reason than
the number of kernel builds most kernel developers do :)

I was going to wait until kbuild 2.5 went into the tree before looking
at what would be needed to add this to the build process.

thanks,

greg k-h
