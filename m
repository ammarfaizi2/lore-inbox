Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTGBSAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTGBSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:00:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49383
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264246AbTGBR7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:59:32 -0400
Date: Wed, 2 Jul 2003 20:13:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702181327.GO23578@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <528080000.1057168362@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528080000.1057168362@flay>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:52:42AM -0700, Martin J. Bligh wrote:
> Indeed - if we could memlock it, it'd be OK to drop that stuff. Would
> make everything a lot simpler.

yes.

Andrea
