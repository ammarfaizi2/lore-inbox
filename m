Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbTDAXVQ>; Tue, 1 Apr 2003 18:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbTDAXVQ>; Tue, 1 Apr 2003 18:21:16 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:670 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262930AbTDAXVP>; Tue, 1 Apr 2003 18:21:15 -0500
Date: Wed, 2 Apr 2003 00:32:29 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
Message-ID: <20030401233229.GC6456@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Daniel Egger <degger@fhm.edu>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com> <1049191863.30759.3.camel@averell> <20030401112800.GA23027@suse.de> <1049197774.31041.15.camel@averell> <Pine.LNX.4.50.0304011105540.8773-100000@montezuma.mastecende.com> <20030401162615.GA1131@suse.de> <1049221861.2643.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049221861.2643.17.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 08:31:01PM +0200, Daniel Egger wrote:

 > > I'm not 100% sure on this, but I *think* 3dnow had an sfence which was
 > > opcode compatable with SSE's instruction.
 > At best the enhanced 3dnow had it. I couldn't find it in the regular
 > 3dnow "technology manual" and don't know where I put the darn other
 > one....

Even the early athlons had 3dnowext, so this is a mystery solved afiacs

		Dave
