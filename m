Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267933AbRGRVXz>; Wed, 18 Jul 2001 17:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267940AbRGRVXp>; Wed, 18 Jul 2001 17:23:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55816 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267933AbRGRVXe>; Wed, 18 Jul 2001 17:23:34 -0400
Date: Wed, 18 Jul 2001 16:52:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Dave McCracken <dmc@austin.ibm.com>, Dirk Wetter <dirkw@rentec.com>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.33L.0107181529100.28730-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0107181651170.8651-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Rik van Riel wrote:

> Hi Alan, Linus,
> 
> Dave found a stupid bug in the swapin code, leading to
> bad balancing problems in the VM.
> 
> I suspect marcelo's zone VM hack could even go away
> with this patch applied ;)

Rik, 

Could you please stop blaming my code with NO reason and understand that
there is a FUNDAMENTAL problem here ?

I don't understand why you're doing this, really. 



