Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRDNTuz>; Sat, 14 Apr 2001 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbRDNTup>; Sat, 14 Apr 2001 15:50:45 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:38918 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132527AbRDNTu2>;
	Sat, 14 Apr 2001 15:50:28 -0400
Date: Sat, 14 Apr 2001 15:51:53 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: jeff millar <jeff@wa1hco.mv.com>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: comments on CML 1.1.0
Message-ID: <20010414155153.A12421@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	jeff millar <jeff@wa1hco.mv.com>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com> <20010414150421.A28066@l-t.ee> <002601c0c4fb$c7e54260$0201a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002601c0c4fb$c7e54260$0201a8c0@home>; from jeff@wa1hco.mv.com on Sat, Apr 14, 2001 at 11:58:41AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff millar <jeff@wa1hco.mv.com>:
> Selecting IP_NF_COMPAT_IPCHAINS turns off IP_NF_CONNTRACK and friends.  But,
> I think CML1, allowed both support to the new iptables and compatibility
> modes to allow old ipchains scripts to work with the new kernel.

Would somebody who knows what these dependencies are please send me a rule
patch?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

...Virtually never are murderers the ordinary, law-abiding people
against whom gun bans are aimed.  Almost without exception, murderers
are extreme aberrants with lifelong histories of crime, substance
abuse, psychopathology, mental retardation and/or irrational violence
against those around them, as well as other hazardous behavior, e.g.,
automobile and gun accidents."
        -- Don B. Kates, writing on statistical patterns in gun crime
