Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286177AbSAEBYi>; Fri, 4 Jan 2002 20:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286198AbSAEBY2>; Fri, 4 Jan 2002 20:24:28 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:2566
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S286196AbSAEBYU>; Fri, 4 Jan 2002 20:24:20 -0500
Date: Fri, 4 Jan 2002 17:24:18 -0800
From: Phil Oester <kernel@theoesters.com>
To: Nicholas Knight <nknight@pocketinet.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Message-ID: <20020104172418.A28715@ns1.theoesters.com>
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp> <20020104220240.233ae66a.skraw@ithnet.com> <WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>; from nknight@pocketinet.com on Fri, Jan 04, 2002 at 04:42:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 04:42:43PM -0800, Nicholas Knight wrote:
> The one catch is that -j is specified without a number.

[snip superfluous description of what 'make -j' implies]

> number, your system is dead. A user issue because it seems the user is 
> using the option without fully comprehending the consequences.

eh?  Trust me - i understand the implications of make -j.  It's not an unreasonable test, especially on a machine with 1gb ram/swap.  For reference, read Rik's email regarding his reverse VM patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101007711817127&w=2

Might be enlightening

-Phil
