Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVGKSlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGKSlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVGKSjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:39:04 -0400
Received: from dvhart.com ([64.146.134.43]:64693 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261640AbVGKSiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:38:11 -0400
Date: Mon, 11 Jul 2005 11:38:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>
Cc: azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <176640000.1121107087@flay>
In-Reply-To: <1120934466.6488.77.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Lots of people have switched from 2.4 to 2.6 (100 Hz to 1000 Hz) with no impact in
>> stability, AFAIK. (I only remember some weird warning about HZ with debian woody's
>> ps).
>> 
> 
> Yes, that's called "progress" so no one complained.  Going back is
> called a "regression".  People don't like those as much.

That's a very subjective viewpoint. Realize that this is a balancing
act between latency and overhead ... and you're firmly only looking
at one side of the argument, instead of taking a comprimise in the
middle ...

If I start arguing for 100HZ on the grounds that it's much more efficient,
will that make 250/300 look much better to you? ;-)

M.

