Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUKSNFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUKSNFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUKSNFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:05:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59824 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261382AbUKSNFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:05:11 -0500
Message-ID: <419DEF79.2090309@pobox.com>
Date: Fri, 19 Nov 2004 08:04:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Andi Kleen <ak@suse.de>, David Woodhouse <dwmw2@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de> <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de> <1100865050.21273.376.camel@baythorne.infradead.org> <20041119120549.GD21483@wotan.suse.de> <419DE33E.2000208@pobox.com> <20041119121909.GF21483@wotan.suse.de> <419DE90D.9030509@pobox.com> <Pine.LNX.4.61.0411190749170.12075@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411190749170.12075@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> Why CONFIG_ISA_BROKEN. That implies (states) that its broken and

The name is appropriate because the drivers in question _are_ broken.

	Jeff


