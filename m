Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSG2CPN>; Sun, 28 Jul 2002 22:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSG2CPN>; Sun, 28 Jul 2002 22:15:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14090 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316182AbSG2CPN>; Sun, 28 Jul 2002 22:15:13 -0400
Date: Sun, 28 Jul 2002 23:18:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of  PAGE_{CACHE_,}{MASK,ALIGN}
In-Reply-To: <3D44A4EB.C5EE33@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0207282317060.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Andrew Morton wrote:

> > Together with the K42 people we found a way to avoid the
> > badnesses of an object-based VM.
>
> eek.  Please let's not tie the delivery of the 2.6 kernel to the success
> of this R&D effort.  We need reasonable-sized fixes, fast, for the
> current problems so that people who have feature work banked up can get
> going on it.

Fully agreed.  We can go with the mechanisms we have now and
should only work on new mechanisms later.

I'm planning to keep the whole K42-style VM thing in design
stage at least until after the feature freeze...

(just so nobody gets tempted to sneak it into the kernel ;))

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

