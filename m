Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289383AbSAJKlu>; Thu, 10 Jan 2002 05:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289382AbSAJKlk>; Thu, 10 Jan 2002 05:41:40 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:5072 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289381AbSAJKl3>;
	Thu, 10 Jan 2002 05:41:29 -0500
Date: Thu, 10 Jan 2002 11:40:57 +0100
From: David Weinehall <tao@acc.umu.se>
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'Paul Koning'" <pkoning@equallogic.com>, dewar@gnat.com,
        mrs@windriver.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020110114056.C5235@khan.acc.umu.se>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E419@IIS000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E419@IIS000>; from Dautrevaux@microprocess.com on Thu, Jan 10, 2002 at 10:03:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 10:03:42AM +0100, Bernard Dautrevaux wrote:

[snip]

> Of course ordering rules must be obeyed, and side effects cannot be moved
> across sequence points. Thus if the two volatile loads are in separate
> instructions, as in:

[snip]

Sorry, if I'm rude, but is this discussion really going anywhere, and
is it really necessary to have on lkml?! The signal/noise-ratio is low
enough as it is.

Instead of arguing about possible interpretations of the C-standard, why
not do some real C-programming instead...


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
