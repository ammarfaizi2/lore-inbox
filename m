Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLTQzv>; Wed, 20 Dec 2000 11:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQLTQzm>; Wed, 20 Dec 2000 11:55:42 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:6927 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129436AbQLTQzf>; Wed, 20 Dec 2000 11:55:35 -0500
Date: Wed, 20 Dec 2000 11:25:02 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
Message-ID: <20001220112502.A10406@alcove.wittsend.com>
Mail-Followup-To: Michael Rothwell <rothwell@holly-springs.nc.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A40DBC2.AEC6B3CA@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <3A40DBC2.AEC6B3CA@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Wed, Dec 20, 2000 at 11:18:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 11:18:10AM -0500, Michael Rothwell wrote:
> IPChains is essentially useless as a firewall due to its lack of

	I think that's more than a little overstatement on your
part.  It depends entirely on the application you intend to put
it to.  It may be entirely useless TO YOU and your applications,
but your statement is far to broad to be accurate.

> stateful packet filering. Will the IPTables code in 2.4 maintain
> connection state?

	Yes it does.  It's clearly stated in all the documentation
on netfilter and in it's design.  Read the fine manual (or web site)
and you would have uncovered this (or been run over by it) for yourself.

	http://netfilter.filewatcher.org/

> -M

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
