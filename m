Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTESBIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTESBIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:08:40 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:22218 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262282AbTESBIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:08:39 -0400
Date: Mon, 19 May 2003 02:24:25 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030519012425.GB18507@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jamie Lokier <jamie@shareable.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
	kraxel@suse.de, jsimmons@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030515151633.GA6128@suse.de> <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk> <20030518053935.GA4112@averell> <20030518161105.GA7404@mail.jlokier.co.uk> <1053290431.27107.4.camel@dhcp22.swansea.linux.org.uk> <20030518223446.GA8591@mail.jlokier.co.uk> <20030518225204.GA21068@suse.de> <20030518233325.GA8888@mail.jlokier.co.uk> <20030519000249.GA18507@suse.de> <20030519002820.GA9048@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519002820.GA9048@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 01:28:20AM +0100, Jamie Lokier wrote:

 > > It works just fine. Just you can't enable MTRRs for framebuffer memory.
 > > Losing a bit of performance for what is (by todays standards) a crap
 > > performing card anyways, is no big deal.
 > 
 > How do you know the blacklist is complete?

no-one complains that they see random crap on their screens any more.
 
		Dave

