Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCBNPX>; Fri, 2 Mar 2001 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRCBNPM>; Fri, 2 Mar 2001 08:15:12 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:51176 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129116AbRCBNPC>;
	Fri, 2 Mar 2001 08:15:02 -0500
Date: Fri, 2 Mar 2001 13:14:45 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apic patches (with MIS counter)
Message-ID: <20010302131445.A2159@grobbebol.xs4all.nl>
In-Reply-To: <20010226111328.A24978@grobbebol.xs4all.nl> <Pine.GSO.3.96.1010226122619.9420C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.3.96.1010226122619.9420C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Feb 26, 2001 at 01:14:11PM +0100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 01:14:11PM +0100, Maciej W. Rozycki wrote:
> On Mon, 26 Feb 2001, Roeland Th. Jansen wrote:
> > if you like, I can start banging the machine on it's head now.
> 
>  Please do.  I believe the code is safe to be included in 2.4.3, but if
> any problem is going to pop up, it'd better do it before than after
> applying to the mainstream. 


banged the box quite a bit. so far no weird things like lockups. 
still 2.4.1. with the MIS counter (etc) patch.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
