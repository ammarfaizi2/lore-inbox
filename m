Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTLKAMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 19:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTLKAMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 19:12:55 -0500
Received: from holomorphy.com ([199.26.172.102]:52707 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264231AbTLKAMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 19:12:54 -0500
Date: Wed, 10 Dec 2003 16:12:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>, Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031211001232.GV8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch> <20031209193801.GF19856@holomorphy.com> <20031210135829.GA18370@k3.hellgate.ch> <20031210174757.GK19856@holomorphy.com> <20031210222355.GB28912@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210222355.GB28912@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:23:55PM +0100, Roger Luethi wrote:
> Level of overcommitment? What kind of criteria is that supposed to be?
> You can have 10x overcommit and not thrash at all, if most of the memory
> is allocated and filled but never referenced again. IOW, I can't derive
> an algorithm from your handwaving <g>.

There is no handwaving; the answer is necessarily ambiguous.


-- wli
