Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUB2Bn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 20:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUB2Bn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 20:43:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61914
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261961AbUB2Bnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 20:43:55 -0500
Date: Sun, 29 Feb 2004 02:43:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040229014357.GW8834@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 09:55:14AM -0500, Rik van Riel wrote:
> The different setups should definately be benchmarked.  I know
> we expected the 4:4 kernel to be slower at everything, but the
> folks at Oracle actually ran into a few situations where the 4:4
> kernel was _faster_ than a 3:1 kernel.
> 
> Definately not what we expected, but a nice surprise nontheless.

this is the first time I hear something like this. Maybe you mean the
4:4 was actually using more ram for the SGA? Just curious.
