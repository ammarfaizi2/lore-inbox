Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289211AbSAGOVK>; Mon, 7 Jan 2002 09:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289214AbSAGOVB>; Mon, 7 Jan 2002 09:21:01 -0500
Received: from ns.ithnet.com ([217.64.64.10]:32004 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289211AbSAGOUw>;
	Mon, 7 Jan 2002 09:20:52 -0500
Date: Mon, 7 Jan 2002 15:20:20 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: brownfld@irridia.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020107152020.6e8d07a4.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0201070021180.872-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201062342150.872-100000@imladris.surriel.com>
	<Pine.LNX.4.33L.0201070021180.872-100000@imladris.surriel.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002 00:22:09 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

> On Sun, 6 Jan 2002, Rik van Riel wrote:
> > On Sat, 5 Jan 2002, Stephan von Krawczynski wrote:
> >
> > > I am pretty impressed by Martins test case where merely all VM patches
> > > fail with the exception of his own :-)
> >
> > No big wonder if both -aa and -rmap only get tested without swap ;)
> 
> To be clear ... -aa and -rmap should of course also work
> nicely without swap, no excuses for the bad behaviour
> shown in Martin's test, but at the moment they simply
> don't seem tuned for it.

Good to hear we agree it _should_ work. When does it (rmap)? 
;-)

Regards,
Stephan


