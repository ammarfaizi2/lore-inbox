Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSAWWmK>; Wed, 23 Jan 2002 17:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289511AbSAWWmA>; Wed, 23 Jan 2002 17:42:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11269 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288566AbSAWWlt>; Wed, 23 Jan 2002 17:41:49 -0500
Date: Wed, 23 Jan 2002 19:30:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Robert Schwebel <robert@schwebel.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201231121380.893-100000@callisto.local>
Message-ID: <Pine.LNX.4.21.0201231930041.4027-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Jan 2002, Robert Schwebel wrote:

> Hi Marcelo,
> 
> the changelog for -pre5 has my AMD Elan fixes included, but unfortunately
> you seem to have forgotten to apply the patch...

I have not applied the serial.c hunk since it breaks compilation without CONFIG_MELAN.

Please fix that and resend me a patch to serial.c only.

Thanks


