Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSCOO7X>; Fri, 15 Mar 2002 09:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292707AbSCOO7O>; Fri, 15 Mar 2002 09:59:14 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:48881 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S292702AbSCOO7C>; Fri, 15 Mar 2002 09:59:02 -0500
Date: Fri, 15 Mar 2002 16:58:44 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: M Sweger <mikesw@ns1.whiterose.net>, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
Subject: Re: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
Message-ID: <20020315145844.GK128921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	M Sweger <mikesw@ns1.whiterose.net>, linux-kernel@vger.kernel.org,
	andre@linux-ide.org
In-Reply-To: <Pine.BSF.4.21.0203150904480.78417-100000@ns1.whiterose.net> <E16lt2T-0003pj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16lt2T-0003pj-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 02:50:37PM +0000, you [Alan Cox] wrote:
> > Hopefully, linux 2.2.x will get the 160gig IDE patch that 2.4.x has.
> 
> Andre's 2.2 patch has been picked up and maintained (I forget by who). I
> don't consider it ever a mainstream 2.2 candidate

I think you mean Krzysztof Oledzki (ole@ans.pl)

From: Krzysztof Oledzki (ole@ans.pl)
Subject: ANNOUNCE - 2.4.x ide backport for 2.2.21pre2 kernel 

http://groups.google.com/groups?q=ANNOUNCE+-+2.4.x+ide+backport+for&hl=en&ie=ISO-8859-1&oe=ISO-8859-1&selm=linux.kernel.Pine.LNX.4.33.0201291654480.17318-100000%40dark.pcgames.pl&rnum=1


BTW: I've heard rumours that some older ide chipsets support 48-bit
addressing with a bios upgrade. HPT370 and Via 686B have been mentioned.

Highpoint windows driver readme:

  v2.1  11/15/2001
          * Add 48bit LBA (Big Drive) support

But I'm not sure whether this means HPT370 or 372 only.

Is this possible and will it be possible to support that functionality in
Linux?


-- v --

v@iki.fi
