Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282670AbRLYJbF>; Tue, 25 Dec 2001 04:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282683AbRLYJaz>; Tue, 25 Dec 2001 04:30:55 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11269 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282670AbRLYJaw>;
	Tue, 25 Dec 2001 04:30:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe I have a bad day or something 
In-Reply-To: Your message of "Tue, 25 Dec 2001 09:09:31 BST."
             <Pine.LNX.4.33.0112250745190.631-100000@mikeg.weiden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Dec 2001 20:30:40 +1100
Message-ID: <32642.1009272640@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001, vda wrote:
> Who fscking care that I am trying to debug a kernel problem and my first
> ksymoops compilation went astray? (I discovered that ksymoops needs bfd lib
> from binutils a month later). We need no stinking decoded oops!
> And we never were newbies, we were born with Linux in our blood!

If you had bothered to look at the INSTALL file in the ksymoops source,
you would have found this :-

  To compile and link ksymoops, you need bfd.h, libbfd and libiberty.  On
  most systems, these are all part of the binutils package so installing
  binutils is all that is required.  On Debian systems, bfd.h (at least)
  is in a separate package, binutils-dev.

Since you are obviously incapable of reading a simple INSTALL file and
then have the gall to complain on linux-kernel while demonstrating your
own ineptitude, you get a free introduction to my kill file.  vda meet
kill file, kill file meet vda.  Goodbye.

