Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287292AbSADNRl>; Fri, 4 Jan 2002 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSADNRc>; Fri, 4 Jan 2002 08:17:32 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:2448
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287292AbSADNRV>; Fri, 4 Jan 2002 08:17:21 -0500
Date: Fri, 4 Jan 2002 08:03:58 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020104080358.A11215@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Andreas Schwab <schwab@suse.de>,
	Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103190219.B27938@thyrsus.com> <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu> <20020103195207.A31252@thyrsus.com> <20020104081802.GC5587@codepoet.org> <20020104071940.A10172@thyrsus.com> <je4rm2l0qz.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <je4rm2l0qz.fsf@sykes.suse.de>; from schwab@suse.de on Fri, Jan 04, 2002 at 02:11:16PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de>:
> |> I'm not very worried about this.  On modern machines int == long 
> 
> You mean alpha, ia64, ppc64, s390x, x68-64 are not modern machines?

Well, S390 certainly isn't! :-)

If the PPC etc. have 32-bit ints then I stand corrected, but I thought the 
compiler ports on those machines used the native register size same as
everybody else.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

All forms of government are pernicious, including good government.
	-- Edward Abbey
