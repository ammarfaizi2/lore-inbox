Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292410AbSBUO7W>; Thu, 21 Feb 2002 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292417AbSBUO7M>; Thu, 21 Feb 2002 09:59:12 -0500
Received: from [209.195.52.114] ([209.195.52.114]:55303 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S292410AbSBUO7I>;
	Thu, 21 Feb 2002 09:59:08 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Giacomo Catenazzi <cate@debian.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, andersen@codepoet.org,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Date: Thu, 21 Feb 2002 06:56:44 -0800 (PST)
Subject: Re: linux kernel config converter
In-Reply-To: <3C75092C.8020508@debian.org>
Message-ID: <Pine.LNX.4.44.0202210655020.8696-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Giacomo Catenazzi wrote:

> David Lang wrote:
>
> >
> > 2. does it handle the 'I want this feature, turn on everything I need for
> > it'?
> >
> > 3. if it handles #2 what does it do if you turn off that feature again
> > (CML2 turns off anything it turned on to support that feature, assuming
> > nothing else needs it)
>
>
> These are tools dependent and not language dependent.
> Please split the two problem: the language and the configuration
> tools.

#3 may be, but #2 isn't possible if the language doesn't provide enough
info for the tool to know what is needed to make a feature work.

David Lang
