Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283916AbRLWTZ3>; Sun, 23 Dec 2001 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284010AbRLWTZT>; Sun, 23 Dec 2001 14:25:19 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:28074
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283916AbRLWTZI>; Sun, 23 Dec 2001 14:25:08 -0500
Date: Sun, 23 Dec 2001 14:11:19 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rob Landley <landley@trommello.org>
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Configure.help editorial policy
Message-ID: <20011223141119.A21710@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>,
	David Garfield <garfield@irving.iisd.sra.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011220143247.A19377@thyrsus.com> <20011222081345.ETGO12125.femail34.sdc1.sfba.home.com@there> <20011222045805.A24575@thyrsus.com> <20011223174227.NCJM25224.femail12.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223174227.NCJM25224.femail12.sdc1.sfba.home.com@there>; from landley@trommello.org on Sun, Dec 23, 2001 at 04:40:26AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> Is the help file even currently accurate with this extra distinction made?  

Not completely, but that's because in some cases I don't know whether decimal
or binary multiples are involved.  Where that is the case I have left the
ambiguous terminology in place.

> And you've already implied you want to change the symbol set for 
> CONFIG_NINO_4MB and such.  How deeply into the kernel will these changes go?

I don't know yet.  I can only clean up the bits for which I am maintainer.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The spirit of resistance to government is so valuable on certain occasions, 
that I wish it always to be kept alive.  It will often be exercised when 
wrong, but better so than not to be exercised at all. I like a little 
rebellion now and then.	-- Thomas Jefferson, letter to Abigail Adams, 1787
