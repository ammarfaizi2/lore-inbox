Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbTIKADW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbTIKADW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:03:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10477 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266078AbTIKADV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:03:21 -0400
Date: Wed, 10 Sep 2003 17:03:03 -0700
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-ID: <20030911000303.GA20329@sgi.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41000000.1063237600@flay>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 04:46:40PM -0700, Martin J. Bligh wrote:
> Yes, it's a turgid mess.
> 
> I'd prefer to define things in terms of MAX_NUMNODES, and derive the shifts
> from that if possible - much more intuitive to maintain.
> But other than that I agree completely with you.

Yeah, I don't mind switching, should just be a search and replace.

> > Could you please get together with Martin Bligh, come up with something
> > which works on NUMAQ and your 128 CPU PDA and also cast an eye across the
> > other architectures (sparc64, sh, ...)?  It all needs a bit of thought and
> > a spring clean.
> 
> I'll have a look, I'm sure we can come up with something between us.

Cool, thanks.

Jesse
