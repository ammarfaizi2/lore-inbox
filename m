Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280714AbRKSVSh>; Mon, 19 Nov 2001 16:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRKSVS2>; Mon, 19 Nov 2001 16:18:28 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:49426 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280714AbRKSVSI>; Mon, 19 Nov 2001 16:18:08 -0500
Date: Mon, 19 Nov 2001 19:17:51 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Remco Post <r.post@sara.nl>, James A Sutherland <jas88@cam.ac.uk>,
        <linux-kernel@vger.kernel.org>, <remco@zhadum.sara.nl>
Subject: Re: Swap 
In-Reply-To: <1922542962.1006204382@[195.224.237.69]>
Message-ID: <Pine.LNX.4.33L.0111191917000.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Alex Bligh - linux-kernel wrote:
> --On Monday, 19 November, 2001 2:58 PM -0200 Rik van Riel
> <riel@conectiva.com.br> wrote:
>
> > Guess again.  Linux doesn't have load control implemented ...
>
> Out of interest, is received wisdom that this is a good/bad
> thing?

Load control is a good thing since it means the box
gets slower in a controlled way instead of running
fine one minute and horribly falling over the next
minute.

I'm certainly planning to implement some load control
measures for 2.5.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

