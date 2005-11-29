Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVK2UgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVK2UgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVK2UgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:36:16 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:23200 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932392AbVK2UgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:36:14 -0500
Date: Tue, 29 Nov 2005 21:36:13 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hpfs: Whitespace and Codingstyle cleanup for dir.c
In-Reply-To: <1133294620.20315.9.camel@localhost>
Message-ID: <Pine.LNX.4.62.0511292131460.2031@artax.karlin.mff.cuni.cz>
References: <200510121326.52216.jesper.juhl@gmail.com> 
 <Pine.LNX.4.62.0510121327580.28884@artax.karlin.mff.cuni.cz> 
 <9a8748490511290717o4d4caa8fi47b9103d0f5ea80b@mail.gmail.com>
 <1133294620.20315.9.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Hi,
>
> On Tue, 2005-11-29 at 16:17 +0100, Jesper Juhl wrote:
>> Well, as Pekka Enberg also pointed out, Documentation/CodingStyle says
>> that's not the prefered way. But, it's your code, so if you don't like
>> the cleanups don't apply them.
>> i still think the patch is a good idea and makes the file more
>> readable though.

I think: if you are going to hack the hpfs code and coding style patches 
will improve your experience, apply them and push them into mainstream 
kernel. Otherwise don't --- they wouldn't help anybody and they would make 
patch merging between 2.0, 2.2, 2.4 and 2.6 version of this driver (yes 
--- I keep all these synchronised) harder.

Mikulas

> I also think the patches are a good idea but it is up to the maintainer,
> of course.
>
> 				Pekka
>
