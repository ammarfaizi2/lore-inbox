Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269132AbTBZWsJ>; Wed, 26 Feb 2003 17:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbTBZWsJ>; Wed, 26 Feb 2003 17:48:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52493 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S269132AbTBZWsI>; Wed, 26 Feb 2003 17:48:08 -0500
Date: Wed, 26 Feb 2003 17:54:43 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops in rpc_depopulate with 2.5.62
In-Reply-To: <7620000.1046277387@[10.10.2.4]>
Message-ID: <Pine.LNX.3.96.1030226175349.17755B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Martin J. Bligh wrote:

> 
> This seems to fix the problem. No idea what it's doing, but it works ;-)

In this case the important thing seems to be what it's *not* doing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

