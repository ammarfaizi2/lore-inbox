Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSFETBc>; Wed, 5 Jun 2002 15:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFETBc>; Wed, 5 Jun 2002 15:01:32 -0400
Received: from scl-ims.phoenix.com ([134.122.1.73]:5900 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S315971AbSFETBa>; Wed, 5 Jun 2002 15:01:30 -0400
Message-ID: <7FD8B823E5024E44B027221DEB34C087536524@scl-exch.phoenix.com>
From: Paul Zimmerman <Paul_Zimmerman@inSilicon.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 12:01:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 18:26, Daniel Phillips wrote: 
> Both approaches have their uses. The second is the one I'm interested in,
> if that isn't already obvious. The first is just a quick hack that will
> give you guaranteed-skipless audio playback, something that Linux is
> currently unable to do. 

What if I'm unfortunate enough to have my sound card share an interrupt
with my IDE controller? Won't my realtime audio player still be at the
mercy of my non-realtime Linux IDE driver? Or does Adeos have a way to
handle that?

-Paul
