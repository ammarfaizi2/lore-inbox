Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265814AbSKDGQG>; Mon, 4 Nov 2002 01:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSKDGQG>; Mon, 4 Nov 2002 01:16:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15369 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265814AbSKDGQF>;
	Mon, 4 Nov 2002 01:16:05 -0500
Date: Mon, 4 Nov 2002 07:21:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Stefan Traby <stefan@hello-penguin.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Patrick Finnegan <pat@purdueriots.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zippel@linux-m68k.org
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021104062118.GA936@mars.ravnborg.org>
Mail-Followup-To: Stefan Traby <stefan@hello-penguin.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Patrick Finnegan <pat@purdueriots.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	zippel@linux-m68k.org
References: <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <1036277779.16971.76.camel@irongate.swansea.linux.org.uk> <20021104045752.GB15844@stefan.atko>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104045752.GB15844@stefan.atko>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 05:57:52AM +0100, Stefan Traby wrote:
> It's definitely not. The current solution is simply a denial of service
> attack, at moment Qt is _required_ for a build, not an optional frontend:
That error is fixed in Linus's tree already.

	Sam
