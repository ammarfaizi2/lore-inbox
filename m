Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSKCQNi>; Sun, 3 Nov 2002 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSKCQNi>; Sun, 3 Nov 2002 11:13:38 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:62499 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262128AbSKCQNi>; Sun, 3 Nov 2002 11:13:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: Petition against kernel configuration options madness...
Date: Sun, 3 Nov 2002 19:20:17 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <20021103160527.GP28803@louise.pinerecords.com>
In-Reply-To: <20021103160527.GP28803@louise.pinerecords.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211031920.17806.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 November 2002 17:05, Tomas Szepe wrote:
> > It took me about an hour to find out why my keyboard didn't work in
> > 2.5.45. Well... after all it seemed that I need to enable 4 ! options
> > inside the input configuration, just to get my default, nothing special
> > PS/2 keyboard up and running. Oh, and I didn't even have my not so fancy
> > boring default PS/2 mouse configured then. Guys, being able to configure
> > everything is nice, but with the 2.5 kernel, things are definitely
> > getting out of control IMHO.
>
> don't blame your inability to understand the consequences of copying a
> .config across ~50 kernel releases on others thank you.

I wont, as long as you don blame someone who -to prevent buggy config files- 
downloaded a fresh 2.5.45 kernel, patched it with the bk-1 update and ran 
make menuconfig after that, of copying .config files.

Jos


