Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275919AbSIUPDS>; Sat, 21 Sep 2002 11:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275920AbSIUPDR>; Sat, 21 Sep 2002 11:03:17 -0400
Received: from are.twiddle.net ([64.81.246.98]:13465 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S275919AbSIUPDR>;
	Sat, 21 Sep 2002 11:03:17 -0400
Date: Sat, 21 Sep 2002 08:08:01 -0700
From: Richard Henderson <rth@twiddle.net>
To: george anzinger <george@mvista.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Daniel Jacobowitz <dan@debian.org>,
       Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020921080801.A28155@twiddle.net>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Daniel Jacobowitz <dan@debian.org>,
	Brian Gerst <bgerst@didntduck.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
References: <24181C771D3@vcnet.vc.cvut.cz> <3D8A11BB.4090100@didntduck.org> <20020919192434.GA3286@nevyn.them.org> <15754.12963.763811.307755@kim.it.uu.se> <3D8ADD05.999E4A5C@mvista.com> <20020920231946.B27148@twiddle.net> <3D8C2928.EC37FEC7@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8C2928.EC37FEC7@mvista.com>; from george@mvista.com on Sat, Sep 21, 2002 at 01:09:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 01:09:12AM -0700, george anzinger wrote:
> > Except the syscall will restart with the corrupted registers.
> > 
> > Hilarity ensues.
> > 
> I submit that BOTH of these are problems.  And only  the
> kernel can fix the latter.

If the later is fixed, so is the former.


r~
