Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286841AbSACFfI>; Thu, 3 Jan 2002 00:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286916AbSACFe6>; Thu, 3 Jan 2002 00:34:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51216 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286841AbSACFex>; Thu, 3 Jan 2002 00:34:53 -0500
Message-ID: <3C33EC64.8E505D54@zip.com.au>
Date: Wed, 02 Jan 2002 21:30:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: "Eric S. Raymond" <esr@thyrsus.com>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> o  Aunt Tilley.
>    Vendors already ship an array of kernels which should make it
>    unnecessary for her to have to build a kernel.
> 

There is a clear advantage to kernel developers in making things as
easy as possible for Aunt Tilley to use our latest output.

If the difficulty of installing the latest kernel prevents her from
doing that, she loses.  And so do we, because we don't get to know
if we've fixed her problem.

If Eric can get the entire download-config-build-install process
down to a single mouse click, he'll have done us all a great service.

-
