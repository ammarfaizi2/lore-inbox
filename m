Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTBERVx>; Wed, 5 Feb 2003 12:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTBERVx>; Wed, 5 Feb 2003 12:21:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261894AbTBERVv>; Wed, 5 Feb 2003 12:21:51 -0500
Date: Wed, 5 Feb 2003 17:31:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Nilmoni Deb <ndeb@ece.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Monta Vista software license terms
Message-ID: <20030205173122.D28758@flint.arm.linux.org.uk>
Mail-Followup-To: Nilmoni Deb <ndeb@ece.cmu.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96L.1030205115551.1886A-100000@ndeb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96L.1030205115551.1886A-100000@ndeb.net>; from ndeb@ece.cmu.edu on Wed, Feb 05, 2003 at 11:58:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IANAL.

In fact, most of the people on this list are not lawyers, so maybe
we're not the most appropriate people to answer your query.

On Wed, Feb 05, 2003 at 11:58:23AM +0000, Nilmoni Deb wrote:
> 	Its the last sentence that is of concern. Does this mean no 3rd
> party (who is not a customer) can get the GPL source code part of their
> products ? Seems like a GPL violation of clause 3b in
> http://www.gnu.org/licenses/gpl.html .

Section 3 seems to apply when a binary is redistributed, and my reading
of section 3b leads me to understand that it would only apply if all
of the following are satisfied:

1. A distributed a binary image to B.
2. A accompanied it with a written offer under section 3b.
3. A did not supply the source code corresponding to that
   binary as per 3a.

> In addition:
> 
> 1. There is no linux kernel source in ftp://ftp.mvista.com/
> 
> 2. The download page http://www.mvista.com/previewkit/index.html does not
> claim to offer any source code at all.

Does the site allow you to download a binary kernel image?  If the
answer is "no" then there isn't a problem here since section 3 does
not apply (no distribution of the program in object code or
executable form).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
