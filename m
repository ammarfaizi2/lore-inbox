Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSIHOhR>; Sun, 8 Sep 2002 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSIHOhQ>; Sun, 8 Sep 2002 10:37:16 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39181 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317984AbSIHOhQ>;
	Sun, 8 Sep 2002 10:37:16 -0400
Date: Sun, 8 Sep 2002 16:53:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "D. Hugh Redelmeier" <hugh@mimosa.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Martin.Knoblauch@teraport.de
Subject: Re: clean before or after dep?
Message-ID: <20020908165323.A1262@mars.ravnborg.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"D. Hugh Redelmeier" <hugh@mimosa.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Martin.Knoblauch@teraport.de
References: <Pine.LNX.4.44.0209072139470.21724-100000@redshift.mimosa.com> <1031490782.26902.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1031490782.26902.4.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Sep 08, 2002 at 02:13:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

README located in the top-level directory specify:
make config
make clean
make dep

Which is the logical order if you ask me.

On Sun, Sep 08, 2002 at 02:13:02PM +0100, Alan Cox wrote:
> The "kernel-howto" has been badly broken for years. The world would
> actually be better without that document IMHO

What about a small HOWTO located in Documentation/ that include a note
that the LDP HOWTO is outdated?

	Sam
