Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312696AbSDKSAd>; Thu, 11 Apr 2002 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSDKSAc>; Thu, 11 Apr 2002 14:00:32 -0400
Received: from port-213-20-128-169.reverse.qdsl-home.de ([213.20.128.169]:36877
	"EHLO drocklinux.dnydns.org") by vger.kernel.org with ESMTP
	id <S312696AbSDKSAb> convert rfc822-to-8bit; Thu, 11 Apr 2002 14:00:31 -0400
Date: Thu, 11 Apr 2002 19:59:21 +0200 (CEST)
Message-Id: <20020411.195921.730560311.rene.rebe@gmx.net>
To: john@antefacto.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20020411174941.GC17962@antefacto.com>
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On: Thu, 11 Apr 2002 17:49:42 +0000,
    "John P. Looney" <john@antefacto.com> wrote:
> On Thu, Apr 11, 2002 at 07:13:39PM +0200, Vojtech Pavlik mentioned:
> > > I'd presumed this was
> > > the whole point of the busid spec in the config file.
> > No, it's for running one Xserver on multiple displays at once only.
> > Sad, ain't it?
> 
>  Very sad. Nice to know it's not really the kernel's fault. 

It IS the kernel's fault, because only one VT can be active. The
kernel VT stuff needs to be redesigned to hadle multiple VT at the
same time ...

>  Is it possible to say "Any mice plugged in to this port is
> /dev/input/mouse3" etc. so that if someone plugged out your mouse, plugged
> in another into a different port, and you plugged yours back in, that they
> wouldn't renumberate ?
> 
> Kate

k33p h4ck1n6
  René

--  
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

