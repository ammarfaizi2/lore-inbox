Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSKHJeq>; Fri, 8 Nov 2002 04:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSKHJep>; Fri, 8 Nov 2002 04:34:45 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:5547 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261723AbSKHJel>;
	Fri, 8 Nov 2002 04:34:41 -0500
Date: Fri, 8 Nov 2002 10:41:22 +0100
From: bert hubert <ahu@ds9a.nl>
To: Mike Diehl <mdiehl@dominion.dyndns.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [documentation] Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021108094122.GB16512@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mike Diehl <mdiehl@dominion.dyndns.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021107091822.GA21030@outpost.ds9a.nl> <20021107.025250.35525477.davem@redhat.com> <20021107130244.GA25032@outpost.ds9a.nl> <20021108023926.51B985606@dominion.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108023926.51B985606@dominion.dyndns.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 08:59:32PM -0500, Mike Diehl wrote:
> So the IPSec in the 2.5 kernel actually works!!!  I had heard it was mostly 
> nonfunctional.

Well, it requires patches still. I hope 2.5.47 will contain everything you
need. As of this moment, there is no set of patches that will apply cleanly
to bitkeeper HEAD to give you working IPSEC, unless you manage to check out
a tree from Thursday morning CET.

Perhaps dave can re-diff?

I'm writing documentation on http://lartc.org/howto/lartc.ipsec.html which
explains how to set everything up.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
