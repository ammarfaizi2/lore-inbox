Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSHIVPa>; Fri, 9 Aug 2002 17:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSHIVPa>; Fri, 9 Aug 2002 17:15:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30220 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316586AbSHIVP3>; Fri, 9 Aug 2002 17:15:29 -0400
Date: Fri, 9 Aug 2002 14:20:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <yodaiken@fsmlabs.com>, Daniel Phillips <phillips@arcor.de>,
       <frankeh@watson.ibm.com>, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.4.44L.0208091613000.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0208091419040.19267-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Rik van Riel wrote:
> 
> To further this point, by how much has the security number
> of Linux improved as a result of the inclusion of the Linux
> Security Module framework ?  ;)
> 
> I'm sure even Linus will agree that the security potential
> has increased, even though he can't measure or quantify it.

Actually, the security number is irrelevant to me - the "noise index" from
people who think security protocols are interesting is what drove that
patch (and that one is definitely measurable).

This way, the security noise is now in somebody elses court ;)

			Linus

