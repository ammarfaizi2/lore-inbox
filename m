Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbSAPUo7>; Wed, 16 Jan 2002 15:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287500AbSAPUov>; Wed, 16 Jan 2002 15:44:51 -0500
Received: from port-212-202-168-51.reverse.qdsl-home.de ([212.202.168.51]:42507
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S287478AbSAPUol> convert rfc822-to-8bit; Wed, 16 Jan 2002 15:44:41 -0500
Date: Wed, 16 Jan 2002 21:43:59 +0100 (CET)
Message-Id: <20020116.214359.521628088.rene.rebe@gmx.net>
To: kristian.peters@korseby.net
Cc: AstinusLists@netcabo.pt, linux-kernel@vger.kernel.org
Subject: Re: ISDN CHANNEL-D
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20020116212122.2f6b7d7a.kristian.peters@korseby.net>
In-Reply-To: <001d01c19ec5$b6f8f740$d500a8c0@mshome.net>
	<20020116212122.2f6b7d7a.kristian.peters@korseby.net>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ;-)

From: Kristian <kristian.peters@korseby.net>
Subject: Re: ISDN CHANNEL-D
Date: Wed, 16 Jan 2002 21:21:22 +0100

> "AstinusLists" <AstinusLists@netcabo.pt> wrote:
> > [..]
> > I would like to know if any of u isdn driver hackers can point me out a way
> > of how to build such a program or where to read some real good stuff about
> > this ISDN-D channel.
> 
> If you're looking for drivers, please go to isdn4linux.de (or search for newsgroups that have "isdn4linux" in their title). As far as I know the current hisax drivers (which are included in the kernel as well) support d-channel. But the d channel is only meant for starting a connection, not to support whole traffic. And it is rather slow. So it would make no fun compared to 64kbs

They support real traffic. The Telekom (here in Germany) used it for a
free (in addition to the normal IDSN internet access ...) "continously
connected" service. For email and chat. It was only a test and never
spread widely ...

[...]

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
