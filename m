Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285070AbRLFJlz>; Thu, 6 Dec 2001 04:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285084AbRLFJlq>; Thu, 6 Dec 2001 04:41:46 -0500
Received: from mail203.mail.bellsouth.net ([205.152.58.143]:26170 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S285070AbRLFJlf>; Thu, 6 Dec 2001 04:41:35 -0500
Message-ID: <3C0F3D49.757F8AFD@mandrakesoft.com>
Date: Thu, 06 Dec 2001 04:41:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "David S. Miller" <davem@redhat.com>, kaos@ocs.com.au,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
In-Reply-To: <20011206.001423.118949508.davem@redhat.com>  <11777.1007619756@kao2.melbourne.sgi.com> <3C0F27CA.59C22DEF@mandrakesoft.com> <15133.1007631619@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> davem@redhat.com said:
> > >    Why not __attribute__((weak)) ?
> > This doesn't work on all platforms unfortunately :(
> 
> Doesn't work at all, or just doesn't work with the (current) minimum
> recommended compiler? We have to increase those minima at some point.

akpm and others will yell :)

egcs-1.1.2 compiles an x86 kernel far faster than newer compilers...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

