Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261922AbTCGXqs>; Fri, 7 Mar 2003 18:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbTCGXqq>; Fri, 7 Mar 2003 18:46:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15889 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261922AbTCGXpe>; Fri, 7 Mar 2003 18:45:34 -0500
Date: Fri, 7 Mar 2003 15:53:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <20030307233653.GD21315@kroah.com>
Message-ID: <Pine.LNX.4.44.0303071551410.1496-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Greg KH wrote:
> 
> I know it's late, sorry.

Not a huge problem, since I don't think klibc itself is a stability issue. 
However, as you say:

> But a lot of code that will need klibc, has not been converted to need
> it yet, due to it not being there :)

Yes. But that's not an argument that flies with me. I really want to see 
people actually using it, for real issues (even if they are potentially 
_small_ real issues).

I feel that people who want to work on early stuff can easily merge it 
themselves (especially if they use BK), and show it to be useful. I don't 
have the slightest feeling that work can't be done unless _I_ merge it.

		Linus

