Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288723AbSADSpQ>; Fri, 4 Jan 2002 13:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288722AbSADSpJ>; Fri, 4 Jan 2002 13:45:09 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:10129
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288675AbSADSpA>; Fri, 4 Jan 2002 13:45:00 -0500
Date: Fri, 4 Jan 2002 13:30:55 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Schwab <schwab@suse.de>, Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020104133055.C15889@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andreas Schwab <schwab@suse.de>,
	Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020104080358.A11215@thyrsus.com> <E16MXjm-0004jo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16MXjm-0004jo-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 04, 2002 at 05:02:34PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Nobody I am aware of uses 64bit int default types on a 64bit platform.  Its
> a waste of memory, bus bandwidth and instruction bandwidth. In almost
> all cases a 32bit int is quite adequate and since size_t can be 64bit when
> int is 32bit life works out nicely.

Thanks for the education.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A wise and frugal government, which shall restrain men from injuring
one another, which shall leave them otherwise free to regulate their
own pursuits of industry and improvement, and shall not take from the
mouth of labor the bread it has earned. This is the sum of good
government, and all that is necessary to close the circle of our
felicities.
	-- Thomas Jefferson, in his 1801 inaugural address
