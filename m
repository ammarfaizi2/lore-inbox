Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSANSQW>; Mon, 14 Jan 2002 13:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288606AbSANSQM>; Mon, 14 Jan 2002 13:16:12 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:46725
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288566AbSANSPz>; Mon, 14 Jan 2002 13:15:55 -0500
Date: Mon, 14 Jan 2002 12:59:32 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114125932.D14747@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Giacomo Catenazzi <cate@debian.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020114111608.B14332@thyrsus.com> <E16QBE1-0002LX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16QBE1-0002LX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 14, 2002 at 05:48:49PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > That would be fine with me.  But wouldn't it involve adding a new
> > initialization-time call to every driver.
> 
> man lsmod

I couldn't make any sense at all out of this until your later posting
saying that compiled-in drivers are going away when initramfs comes in.
You might try being a *little* less terse...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Love your country, but never trust its government.
	-- Robert A. Heinlein.
