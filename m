Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136832AbREITDl>; Wed, 9 May 2001 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136830AbREITDa>; Wed, 9 May 2001 15:03:30 -0400
Received: from [63.95.87.168] ([63.95.87.168]:16645 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S136826AbREITDP>;
	Wed, 9 May 2001 15:03:15 -0400
Date: Wed, 9 May 2001 15:03:13 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: God <atm@sdk.ca>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.rutgers.edu
Subject: Re: ECN: Volunteers needed
Message-ID: <20010509150313.C13226@xi.linuxpower.cx>
In-Reply-To: <20010509102509.B13226@xi.linuxpower.cx> <Pine.LNX.4.21.0105091301070.23642-100000@scotch.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.LNX.4.21.0105091301070.23642-100000@scotch.homeip.net>; from atm@sdk.ca on Wed, May 09, 2001 at 01:08:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 01:08:31PM -0400, God wrote:
> On Wed, 9 May 2001, Gregory Maxwell wrote:
> 
> > 2) They certainly are.  Every once in a while they go through a period of
> >    silently dropping all email coming from hosts that don't have PTRs.
> >    This would be no worse.
> 
> ACK .... Which do you mean? :
> 
> -Hosts that don't have valid PTRs (which would be no PTR at all -- Not
> deliverable, but not because AOL said so)
> 
> -Hosts that don't have valid PTRs, but DO have at least one valid MX
> (Forward and reverse)
> 
> -Same as above, but said hosts MX's forward and/or reverse don't match
> 
> etc etc ....   I ask this simply because I DO know of users who have
> complained their E-Mail to/from an AOL customer, didn't get there.  I've
> always assumed .. well ... AOL user .. no comment :)

AFIK, mail which contains Path with host names which don't pass a two-way
check (forward, reverse the forward) AOL drops. Not always though, MX
records are irrelevantly.
