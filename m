Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289456AbSAOJVn>; Tue, 15 Jan 2002 04:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289455AbSAOJVe>; Tue, 15 Jan 2002 04:21:34 -0500
Received: from [195.157.147.30] ([195.157.147.30]:52495 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S289450AbSAOJVW>; Tue, 15 Jan 2002 04:21:22 -0500
Date: Tue, 15 Jan 2002 09:14:14 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, Rob Landley <landley@trommello.org>,
        Charles Cazabon <charlesc@discworld.dyndns.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou \(ETL\)" <Michael.Lazarou@etl.ericsson.se>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115091414.A3928@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>,
	Charles Cazabon <charlesc@discworld.dyndns.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114125508.A3358@twoflower.internal.do> <20020114135412.D17522@thyrsus.com> <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there> <20020114173423.A23081@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114173423.A23081@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 05:34:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 05:34:23PM -0500, Eric S. Raymond wrote:
> Because the second we stop thinking about Aunt Tillie,
> we start making excuses for badly-designed interfaces and excessive
> complexity. 

Bollocks.  The second we (including you) stop thinking about the _user_ of the
technology, we make bad decisions.  This is not the same thing.  

We don't expect Aunt Tillie to write kernel drivers for her knitting machine.
She (and we) expect(s) someone else to do that for her.

The Aunt Tillies of this world don't install of update Windows (or Mac O/S) for
themselves except perhaps via "Windows Update" or "Apple Update", which (guess
what) supplies a prebuilt binary and DOESN'T BUILD THEM A KERNEL.

Besides any other factor, the download/install/reboot time is less than the
download-full-tarball/untar/configure/compile/install/reboot cycle.

Sean
