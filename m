Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbSKQABG>; Sat, 16 Nov 2002 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSKQABG>; Sat, 16 Nov 2002 19:01:06 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21261 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S267412AbSKQABG>;
	Sat, 16 Nov 2002 19:01:06 -0500
Date: Sun, 17 Nov 2002 01:08:01 +0100
From: romieu@fr.zoreil.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021117010801.A21229@electric-eye.fr.zoreil.com>
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com> <20021116151102.GI19015@higherplane.net> <3DD6B2C5.3010303@pobox.com> <20021116213732.GO24641@conectiva.com.br> <20021116214250.GQ24641@conectiva.com.br> <1037490677.24843.7.camel@irongate.swansea.linux.org.uk> <3DD6DE32.60503@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD6DE32.60503@kegel.com>; from dank@kegel.com on Sat, Nov 16, 2002 at 04:09:22PM -0800
X-Disclaimer: Mae'r e-bost hwn yn hollol gyfrinachol ac mae ar gyfer defnydd y derbynnydd/derbynwyr yn unig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc trimmed]

Dan Kegel <dank@kegel.com> :
[...]
> So how 'bout this:
> 
> * mark all drivers that don't compile OBSOLETE.  That keeps us from
>    trying to fix drivers without having hardware to test them.
>    Anyone with proper hardware is invited to fix the drivers and then
>    mark them non-OBSOLETE.

Plain old #warning doesn't work that bad and requires 0 extra new feature.

--
Ueimor
