Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287717AbSAACn6>; Mon, 31 Dec 2001 21:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAACns>; Mon, 31 Dec 2001 21:43:48 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:15923 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287717AbSAACnj>; Mon, 31 Dec 2001 21:43:39 -0500
Date: Mon, 31 Dec 2001 21:43:22 -0500
From: Bill Nottingham <notting@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        James Simmons <jsimmons@transvirtual.com>,
        Scott McDermott <vaxerdec@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-ID: <20011231214322.A26481@nostromo.devel.redhat.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	James Simmons <jsimmons@transvirtual.com>,
	Scott McDermott <vaxerdec@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011231195655.A16870@conectiva.com.br> <Pine.LNX.4.10.10112311425020.12522-100000@www.transvirtual.com> <20011231203112.A16975@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011231203112.A16975@conectiva.com.br>; from acme@conectiva.com.br on Mon, Dec 31, 2001 at 08:31:12PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo (acme@conectiva.com.br) said: 
> My card is a Neomagic, so I use vesafb...
> 
> Please let me know if somebody has specs for:
> 
> 00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
> 128XD] (rev 01)

Someone wrote a neomagic framebuffer driver at some point; ISTR
the patch showing up on linux-kernel. Mind you, I don't know that
it was accelerated at all...

Bill
