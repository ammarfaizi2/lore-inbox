Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292081AbSBTRZe>; Wed, 20 Feb 2002 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292079AbSBTRZQ>; Wed, 20 Feb 2002 12:25:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37391 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292063AbSBTRZF>; Wed, 20 Feb 2002 12:25:05 -0500
Date: Wed, 20 Feb 2002 14:24:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Ville Herva <vherva@twilight.cs.hut.fi>,
        george anzinger <george@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <20020220172052.GA15228@matchmail.com>
Message-ID: <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Mike Fedyk wrote:
> On Wed, Feb 20, 2002 at 01:36:02PM +0200, Ville Herva wrote:
> > asm-ia64/param.h:# define HZ    1024
> > asm-x86_64/param.h:#define HZ 100
>
> What's the difference between these two architectures?  Intel 64bit
> processor and AMD's upcoming 64bit processor?

One is a 64 bit extension to a modern superscalar
architecture which has descended from 8 bit machines
over the ages.

The other is a 3-issue VLIW follow-up to the 2-issue
VLIW i860.

cheers,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

