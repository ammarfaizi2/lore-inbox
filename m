Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281965AbRKUU02>; Wed, 21 Nov 2001 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281969AbRKUU0S>; Wed, 21 Nov 2001 15:26:18 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9991 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281965AbRKUU0E>; Wed, 21 Nov 2001 15:26:04 -0500
Date: Wed, 21 Nov 2001 18:25:25 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: george anzinger <george@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Memory allocation question
In-Reply-To: <3BFC0AD5.5A4802D@mvista.com>
Message-ID: <Pine.LNX.4.33L.0111211825060.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, george anzinger wrote:

> /*
>  * The old interface name will be removed in 2.5:
>  */
> #define get_free_page get_zeroed_page
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Where as __get_free_page() does not zero.  I know this is an old
> kernel, but...

Urghhh, you're right.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

