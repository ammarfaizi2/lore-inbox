Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWAOKNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWAOKNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWAOKNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:13:37 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:2671 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750768AbWAOKNg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:13:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HjvlLqSVFNlQToMJ8512KlxALZXRo4C6EAVUiTddqNY/EqqfuFC6H7y71ZQQW9tEWJ+SEWsBLwb5wQFmGD8J0XhI2X6/DWUbbD7tYESvYWH+PnfoFIPd3dR3wqm92BbC0JgE2ciktDcQIjZOoWpwV/rmICZ/j1D6gibzVPfOuKE=
Message-ID: <eb0e02f40601150213g4589820csfc508f4ba2271cb4@mail.gmail.com>
Date: Sun, 15 Jan 2006 21:13:36 +1100
From: Grant Coady <gcoady@gmail.com>
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
In-Reply-To: <200601151051.14827.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200601151051.14827.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/06, René Rebe <rene@exactcode.de> wrote:
> with at least 2.6.15-mm{2,3,4} untaring the kernel and running make menuconfig
> (or most other favourite config tools) do not display a version anymore since
> .kernelrelease it not build as dependecy.

grant@sempro:~/linux/linux-2.6.15-mm4a$ cat .kernelrelease
2.6.15-mm4a

Works for me ;)

Grant.
