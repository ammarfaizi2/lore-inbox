Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDPVyw>; Mon, 16 Apr 2001 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRDPVym>; Mon, 16 Apr 2001 17:54:42 -0400
Received: from spc2.esa.lanl.gov ([128.165.67.191]:2432 "HELO
	spc2.esa.lanl.gov") by vger.kernel.org with SMTP id <S132327AbRDPVyh>;
	Mon, 16 Apr 2001 17:54:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
Date: Mon, 16 Apr 2001 16:00:38 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010416174223.A21689@thyrsus.com>
In-Reply-To: <20010416174223.A21689@thyrsus.com>
Cc: elenstev@mesatop.com
MIME-Version: 1.0
Message-Id: <01041616003800.01249@spc2.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 April 2001 15:42, Eric S. Raymond wrote:
> CML2 NEWS
>
> The latest version is always available at http://www.tuxedo.org/~esr/cml2/
>
> Release 1.1.3:
> 	* Freeze color changed from cyan to blue.
> 	* Tom Rini's network-configuration patches.
> 	* Better detection of set variables to be colored green.
> 	* Minor resize and scrolling fixes in menuconfig.
> 	* Fixed a rather nasty bug involving side-effect computation
> 	  that showed up if you set, unset, and reset a symbol in a
> 	  choices menu.
> 	* In non-choice menus, select bar is now advanced after [ymn].
>
> Point release -- bug fixes and UI cleanups.

Whoops,  I just tried out 1.1.3 using make xconfig, and now all the option labels
are dark green, not just the ones set to y.

Thanks for changing the freeze color to blue.  That is much more readable against
the silver background for make xconfig.

Steven
