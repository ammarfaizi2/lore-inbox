Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbTLISb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266090AbTLISb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:31:59 -0500
Received: from holomorphy.com ([199.26.172.102]:48095 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266085AbTLISb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:31:58 -0500
Date: Tue, 9 Dec 2003 10:31:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>, Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031209183145.GQ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209151103.GA4837@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 04:11:03PM +0100, Roger Luethi wrote:
> I'm afraid you have a solution in search of a problem. Nobody runs a
> 10x overcommit system. And if they did, they would find it doesn't work
> well with 2.4, either, so no one will complain about a regression. What
> does happen, though, is that people go close to the limit of what
> their low-end hardware supports, which will work perfectly with 2.4
> and collapse with 2.6.

No, I've got a guy in Russia complaining about 2.6 not doing well on
one of his boxen.


-- wli
