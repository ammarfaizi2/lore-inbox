Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTKWMCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 07:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTKWMCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 07:02:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:52899 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263369AbTKWMCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 07:02:08 -0500
Date: Sun, 23 Nov 2003 13:01:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Andi Kleen <ak@muc.de>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com, efocht@hpce.nec.com,
       John Hawkes <hawkes@sgi.com>, wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
In-Reply-To: <3FC0A0C2.90800@cyberone.com.au>
Message-ID: <Pine.LNX.4.56.0311231300290.16152@earth>
References: <20031117021511.GA5682@averell> <3FB83790.3060003@cyberone.com.au>
 <20031117141548.GB1770@colin2.muc.de> <Pine.LNX.4.56.0311171638140.29083@earth>
 <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth>
 <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au>
 <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au>
 <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au>
 <3FC0A0C2.90800@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Nick Piggin wrote:

> We still don't have an HT aware scheduler, [...]

uhm, have you seen my HT scheduler patches, in particular the HT scheduler
in Fedora Core 1, which is on top of a pretty recent 2.6 scheduler? Works
pretty well.

	Ingo
