Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWI2ElA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWI2ElA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 00:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWI2ElA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 00:41:00 -0400
Received: from ns1.suse.de ([195.135.220.2]:60828 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751558AbWI2Ek7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 00:40:59 -0400
From: Neil Brown <neilb@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Date: Fri, 29 Sep 2006 14:40:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.41932.957298.877577@cse.unsw.edu.au>
Cc: tridge@samba.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: message from James Bottomley on Thursday September 28
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 28, James.Bottomley@SteelEye.com wrote:
> It's the "act of running the program is not restricted".
> 
> This is really the crux of the argument with the FSF over the DRM
> clauses.  If you take the position (as the people who signed the
> discussion paper do) that embedded Linux constitutes an end use, then
> this freedom from restriction of running the programme is compromised in
> GPLv3, and hence is against the spirit of GPLv2 (and thus violates
> clause 9 of GPLv2).

I hadn't seen this distinction before, and it is probably worth
repeating and exploring a bit.

You seem to be saying that including software in a product that you
then distribute is *both* a USE and a DISTRIBUTION of that software.
So if the software is obtained under the GPL, and the GPL asserts "no
restrictions on use" then it should also not restrict distribution.
It can place requirements that must be met before distribution is
allowed, but they shouldn't be so onerous as to inhibit distribution.
Does that sound right?

The requirements in GPLv2 are not sufficient to prevent distribution.
The requirements in GPLv3-draft are - they might require modification
to the device which might make it illegal to sell (?).

Presumably this doesn't just apply to embedded uses.
When Redhat or Novell/SuSE make a Enterprise Distribution, they are
"using" Linux just as much as a company produces devices with embedded
Linux are.

So if GPLv3 required not only that you give away the right to assert
your patents, and give away certain secrets (keys) but also that you
give up the right to protect your Trademarks, then Redhat would
probably be very unhappy about that, as might Mozilla.  Fortunately
GPLv3-draft doesn't make that requirement.
I wonder what v4 will do :-) 

I wonder how hard it is to modify the hardware of a Tivo-2 to allow
software updates (it was done for the Xbox after all), and if the
difference between that and the effort of removing trade marks from
RHEL (just producing whitebox) is a difference of degree or a
difference of kind....

NeilBrown

