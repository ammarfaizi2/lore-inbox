Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUIAMXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUIAMXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIAMXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:23:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:11221 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266250AbUIAMXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:23:38 -0400
Date: Wed, 1 Sep 2004 08:28:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Oliver Hunt <oliverhunt@gmail.com>
Cc: Romain Moyne <aero_climb@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
In-Reply-To: <4699bb7b04090105182c5591a9@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409010826500.4481@montezuma.fsmlabs.com>
References: <200409021453.09730.aero_climb@yahoo.fr>
 <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
 <4699bb7b04090105182c5591a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Oliver Hunt wrote:

> Is it just me or the bogomips rating listed there completely out of whack?

Yes it is, you'll also note that the cpu clock frequency is also low,
hence my suspicion of cpufreq, which would affect general timing.
