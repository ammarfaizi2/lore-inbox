Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289712AbSAJVro>; Thu, 10 Jan 2002 16:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289706AbSAJVrf>; Thu, 10 Jan 2002 16:47:35 -0500
Received: from web14903.mail.yahoo.com ([216.136.225.55]:21177 "HELO
	web14903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289710AbSAJVrY>; Thu, 10 Jan 2002 16:47:24 -0500
Message-ID: <20020110214723.23084.qmail@web14903.mail.yahoo.com>
Date: Thu, 10 Jan 2002 16:47:22 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: About Loop Device
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C3DFF15.7090707@broadpark.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I use those techniques, does it mean that I need to
add some patch to the kernel? I need to recompile the
kernel?

Michael


--- Gisle Sælensminde <gisle.selensminde@broadpark.no>
wrote:
> 
> If you want to encrypt, the standard kernel is not
> sufficient, Instead, 
> you should the cryptoapi
> og loop-aes modules, that is distributed separatly
> from the kernel. The 
> Linux cryprography mailing
> list is probably of interest too
> 
> Mailing list info:
> 
> http://mail.nl.linux.org/linux-crypto/
> 
> cryptoapi:  http://cryptoapi.sourceforge.net
> loop-aes:   http://loop-aes.sourceforge.net/
> 
> Hope this helps.
> 
> - Gisle
> 


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
