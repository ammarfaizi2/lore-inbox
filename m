Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVLTOII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVLTOII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVLTOII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:08:08 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:35018 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751056AbVLTOIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:08:06 -0500
Date: Tue, 20 Dec 2005 09:07:56 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.15-rc5-rt2 slowness
In-Reply-To: <20051220135725.GA29392@elte.hu>
Message-ID: <Pine.LNX.4.58.0512200907110.22312@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain>
 <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu>
 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Ingo Molnar wrote:
>
> well, the SLOB is mainly about being simple and small. So as long as
> those speedups are SMP-only, they ought to be fine. The problems are
> mainly SMP related, correct?

Oh, but if this does work out, it _will_ improve SMP performance greatly!

-- Steve

