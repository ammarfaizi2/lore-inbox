Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262091AbREUR43>; Mon, 21 May 2001 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbREUR4T>; Mon, 21 May 2001 13:56:19 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:1542 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262091AbREUR4D>;
	Mon, 21 May 2001 13:56:03 -0400
Date: Mon, 21 May 2001 13:58:57 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Wayne.Brown@altec.com
Cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
Message-ID: <20010521135857.B11361@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Wayne.Brown@altec.com, David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <86256A53.0060ACF6.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86256A53.0060ACF6.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Mon, May 21, 2001 at 12:36:48PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com <Wayne.Brown@altec.com>:
> Speaking from the perspective of a user of the CML tools, rather
> than as a developer, all I've been trying to say is this: When I
> type "make menuconfig" or "make oldconfig" in the future, I want to
> see the same interface and the same results that I've always seen,
> because it's always worked for me in the past.

Visual details will differ, but I've been careful about maintaining
functional compatibility.  There was a phase of the development during
which I was mostly processing feature requests from people who wanted
features of the old system that I had not properly understood (such as
the NEW tag).  That phase ended almost a month ago.  Nobody who has
actually tried the CML2 tools more recently has reported that the UI
changes present any difficulty.

CML2 drops its configuration results in the same place, in the same
formats, as CML1.  So you should in fact be able to type `make menuconfig'
and `make oldconfig' with good results.  Have you actually tried this?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The right of the citizens to keep and bear arms has justly been considered as
the palladium of the liberties of a republic; since it offers a strong moral
check against usurpation and arbitrary power of rulers; and will generally,
even if these are successful in the first instance, enable the people to resist
and triumph over them."
        -- Supreme Court Justice Joseph Story of the John Marshall Court
