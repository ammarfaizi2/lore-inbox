Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRDKNsv>; Wed, 11 Apr 2001 09:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDKNsb>; Wed, 11 Apr 2001 09:48:31 -0400
Received: from datafoundation.com ([209.150.125.194]:3337 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S130485AbRDKNsa>; Wed, 11 Apr 2001 09:48:30 -0400
Date: Wed, 11 Apr 2001 09:48:18 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: info <5740@mail.ru>
cc: <linux-kernel@vger.kernel.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: 2.4.3 compile error No 4
In-Reply-To: <01041111564300.02619@sh.lc>
Message-ID: <Pine.LNX.4.30.0104110947430.19243-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, info wrote:

> OS: Mandrake 6.0RE
> AMD K6-200 144 M
> gcc 2.95.2-ipl3mdk
>
> # CONFIG_IPX_INTERN is not set
> # CONFIG_SYSCTL is not set
> CONFIG_HPFS_FS=y
>
> Compiler error message No 4:

this may be a stupid question, but are you doing a 'make clean' after
changing config parameters?


