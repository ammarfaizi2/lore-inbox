Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTKWMXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 07:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTKWMXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 07:23:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21122 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263375AbTKWMXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 07:23:04 -0500
Date: Sun, 23 Nov 2003 13:21:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Andi Kleen <ak@muc.de>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com, efocht@hpce.nec.com,
       John Hawkes <hawkes@sgi.com>, wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
In-Reply-To: <3FC0A4D3.9020604@cyberone.com.au>
Message-ID: <Pine.LNX.4.56.0311231320090.16638@earth>
References: <20031117021511.GA5682@averell> <3FB83790.3060003@cyberone.com.au>
 <20031117141548.GB1770@colin2.muc.de> <Pine.LNX.4.56.0311171638140.29083@earth>
 <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth>
 <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au>
 <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au>
 <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au>
 <3FC0A0C2.90800@cyberone.com.au> <Pine.LNX.4.56.0311231300290.16152@earth>
 <3FC0A4D3.9020604@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Nick Piggin wrote:

> I just meant that there is not one in Linus' tree yet.

yes, because when i wrote it we were already in a feature freeze, and the
changes are intrusive. And being the scheduler maintainer i'm supposed to
show a certain level of self restraint :-)

	Ingo
