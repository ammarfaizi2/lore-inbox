Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHWXN2>; Thu, 23 Aug 2001 19:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270705AbRHWXNS>; Thu, 23 Aug 2001 19:13:18 -0400
Received: from [209.38.98.99] ([209.38.98.99]:29057 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S268071AbRHWXNL>;
	Thu, 23 Aug 2001 19:13:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: "Tony Hoyle" <tmh@nothing-on.tv>, linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
Date: Thu, 23 Aug 2001 18:13:20 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01082316383301.12104@bits.linuxball> <9m41qd$290$1@sisko.my.home>
In-Reply-To: <9m41qd$290$1@sisko.my.home>
MIME-Version: 1.0
Message-Id: <01082318132000.12319@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so why dos my filesystem have a 2 GB limit?
Must I specify a large block size or some such when i format?

i run 2.4.9 on redhat7.1 out of the box

Fred

 _________________________________________________ 
On Thursday 23 August 2001 05:58 pm, Tony Hoyle wrote:
> In the ancient scrolls of Usenet, page
> <01082316383301.12104@bits.linuxball>, "Fred" <fred@arkansaswebs.com>
>
> spake thus:
> > I need some basic info on File Size Limitations on filesystems such as
> > ext2/3 and ntfs.
>
> ext2/4 use are 64bit these days.  I guess signed so they'd have limit of
> 2TB per partition/file.
>
> Tony
