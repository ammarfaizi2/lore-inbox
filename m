Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284763AbRL1XZi>; Fri, 28 Dec 2001 18:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284612AbRL1XZW>; Fri, 28 Dec 2001 18:25:22 -0500
Received: from [195.63.194.11] ([195.63.194.11]:65035 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S284393AbRL1XX1>; Fri, 28 Dec 2001 18:23:27 -0500
Message-ID: <3C2CFC42.7000401@evision-ventures.com>
Date: Sat, 29 Dec 2001 00:12:02 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
In-Reply-To: <Pine.LNX.4.33.0112281504210.23482-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 28 Dec 2001, Alan Cox wrote:
>
>>It would certainly fit nicely with the existing metadata. We already rip out
>>code comments via kernel-doc, and extending it to rip out
>>
>>	-	Help text
>>	-	Web site
>>
>...
>
>No no no.
>
>The comments can at least be helpful to programmers, whether ripped out or
>not.
>
>Extra stuff is not helpful to anybody, and is just really irritating. I
>personally despise source trees that start out with one page of copyright
>statement crap, it just detracts from the real _point_ of the .c file,
>which is to contain C code. Making it a comment requirement is
>
> - stupid:
>	we have a filesystem, guys
>
Not quite... It is making moving patches  through e-mail around easier...

>

