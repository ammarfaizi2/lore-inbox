Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289314AbSBNA62>; Wed, 13 Feb 2002 19:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289288AbSBNA6S>; Wed, 13 Feb 2002 19:58:18 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:20110 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289282AbSBNA6F>;
	Wed, 13 Feb 2002 19:58:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: How to check the kernel compile options ?
Date: Thu, 14 Feb 2002 02:02:48 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213163646.12448B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020213163646.12448B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bAIS-0002Qs-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 10:51 pm, Bill Davidsen wrote:
> On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> 
> > The advantage, of course is that if you are executing the kernel,
> > it can give you all the information necessary to recreate a
> > new one from the sources because its .config is embeded into
> > itself. Once you have the ".config" file, you just do `make oldconfig`
> > and you are home free.
> 
> But it does no such thing! You not only need the config file, you need the
> source.

The source is readily available, the specific config used for your kernel may
not be.

> This feature just isn't all that useful,

Given your little logic slip above I'm not sure I should trust your conclusion.
OK, I'm out of here, I'm not interested in discussing why any more, only how.

-- 
Daniel
