Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSA2R15>; Tue, 29 Jan 2002 12:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSA2R1s>; Tue, 29 Jan 2002 12:27:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16143 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289775AbSA2R1m>; Tue, 29 Jan 2002 12:27:42 -0500
Date: Tue, 29 Jan 2002 15:27:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hartmut Holz <hartmut.holz@arcor.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: rmap12a slower than rmap11c (mpeg/VCD)
In-Reply-To: <3C56CCED.6040801@arcor.de>
Message-ID: <Pine.LNX.4.33L.0201291526170.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Hartmut Holz wrote:

> if I play mpeg/VCD with rmap12a, I recognize that rmap12a is slower
> than rmap11c. (PII 450 MHz - SMP, Matrox G450 - PCI). I think there's
> nothing to measure. GTV shows with both patches about 25 fps. But what
> I see on the screen is different

It would be interesting if you could show me 10 lines of
'vmstat 5' output with both kernels so I have a better
idea of where to start tracking down the problem ...

(even if it isn't directly measurable "feeling slower"
is a bug I want to fix)

kind regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

