Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSHKQWT>; Sun, 11 Aug 2002 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSHKQWT>; Sun, 11 Aug 2002 12:22:19 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:49421 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317286AbSHKQWT>;
	Sun, 11 Aug 2002 12:22:19 -0400
Date: Sun, 11 Aug 2002 18:33:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/12] eyestrain relief
Message-ID: <20020811183348.A23614@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D5464A4.84FC2DF3@zip.com.au> <20020810121430.A6215@infradead.org> <20020810163608.A1258@mars.ravnborg.org> <20020810153617.A9413@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020810153617.A9413@infradead.org>; from hch@infradead.org on Sat, Aug 10, 2002 at 03:36:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 03:36:17PM +0100, Christoph Hellwig wrote:
> > Any plans to share parser.y with the rest of the world?
> > It is missing in the tar-ball.
> 
> It's below.  Bonus points go to the one who submits the automake magic
> to generated parser.tab.{c,h} on the fly.

I would rather see Configure and Menuconfig being replaced by mconfig.
What prevents us from doing exactly that?

o Missing colors in menu mode
o That it spit more warnings than people are used to
o That it emit errors for constructs silently accepted by Configure
o Or something that I missed out totally?

	Sam
