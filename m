Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbRA0TXM>; Sat, 27 Jan 2001 14:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135271AbRA0TXC>; Sat, 27 Jan 2001 14:23:02 -0500
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:33031 "EHLO Ion.var.cx")
	by vger.kernel.org with ESMTP id <S131139AbRA0TW4>;
	Sat, 27 Jan 2001 14:22:56 -0500
Date: Sat, 27 Jan 2001 20:22:59 +0100
From: Frank v Waveren <fvw@var.cx>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: David Wagner <daw@cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127202259.A3857@var.cx>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no> <94tho8$627$1@abraham.cs.berkeley.edu> <20010127191809.A3727@var.cx> <20010127142032.E6821@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010127142032.E6821@xi.linuxpower.cx>; from greg@linuxpower.cx on Sat, Jan 27, 2001 at 02:20:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 02:20:32PM -0500, Gregory Maxwell wrote:
> > Why? Why not just zero them, and get both security and compatibility...
> Eeek! NO!!!! NO NO NO NO NO NO NO!
> For ECN that would have worked, but that doesn't mean that something
> couldn't have been implimented there that wouldn't have worked that way..
> I think that older Checkpoint firewalls (perhaps current?) zeroed out SACK
> on 'hide nat'ed connections. This causes unreasonable stalls for users on
> SACK enabled clients. Not cool.

Point taken. So much for thinking simple... :-} 

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|dse.nl|stack.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: http://www.var.cx/pubkey/fvw@var.cx-gpg     7179 3036 E136 B85D

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
