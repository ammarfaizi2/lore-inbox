Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275156AbRJFOEJ>; Sat, 6 Oct 2001 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275173AbRJFOD7>; Sat, 6 Oct 2001 10:03:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24329 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275156AbRJFODm>;
	Sat, 6 Oct 2001 10:03:42 -0400
Date: Sat, 6 Oct 2001 11:03:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, <linux-xfs@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.3.96.1011006154039.27272A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33L.0110061103000.12110-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Mikulas Patocka wrote:

> Buddy allocator is broken - kill it. Or at least do not misuse it for
> anything except kernel or driver initialization.

Please send patches to get rid of the buddy allocator while
still making it possible to allocate contiguous chunks of
memory.

If you have any idea on how to fix things, this would be a
good time to let us know.

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

