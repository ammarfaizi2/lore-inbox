Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270873AbRHPPxL>; Thu, 16 Aug 2001 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271579AbRHPPxC>; Thu, 16 Aug 2001 11:53:02 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:11791 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S270873AbRHPPwo>;
	Thu, 16 Aug 2001 11:52:44 -0400
Date: Thu, 16 Aug 2001 17:52:51 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Peter Koellner <peter@mezzo.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.8-ac5] Another Sony Vaio laptop with a broken APM...
Message-ID: <20010816175251.M8473@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010816173420.J8473@come.alcove-fr> <Pine.LNX.4.21.0108161738390.8142-100000@finnegan.do.mezzo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0108161738390.8142-100000@finnegan.do.mezzo.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 05:47:17PM +0200, Peter Koellner wrote:

> > However, the Vaio bioses list is getting bigger and bigger
> > and I wonder if there is _any_ Vaio laptop that gets this
> > item right. If not, we could just do a search on SYS_VENDOR /
> > PRODUCT_NAME strings, like the is_sony_vaio_laptop test...
> > 
> > Comments ?
> 
> at least you got one with apm battery support at all, which is not the 
> case with lots of newer vaio laptops. if my observation is right,
> sony and phoenix are about to remove apm support in the NoteBIOS
> completely. most of the latest FX models seem to have their APM bios
> completely broken.

I should say that battery status is almost the only support I get 
from the BIOS. (suspend/resume was supported by the older Vaio bioses.)

I'd qualify my C1VE Picturebook as a 80% ACPI - 20% APM machine.
I would not be surprised at all if newer machines go 100% ACPI... :-(

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
