Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTGCWuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTGCWuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:50:00 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49353
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265474AbTGCWt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:49:58 -0400
Date: Thu, 3 Jul 2003 21:34:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, mbligh@aracnet.com, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703193441.GO23578@dualathlon.random>
References: <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com> <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com> <20030702233014.GW23578@dualathlon.random> <20030702235540.GK26348@holomorphy.com> <20030703113144.GY23578@dualathlon.random> <20030703120658.4fb1e407.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703120658.4fb1e407.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 12:06:58PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Yet another issue is that mlock at max locks in half of the physical
> > ram,
> 
> I deleted that bit.

that's ok with me, I'm not going to deadlock my machine with it anyways ;).

Andrea
