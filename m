Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267913AbTAHTEw>; Wed, 8 Jan 2003 14:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267917AbTAHTEw>; Wed, 8 Jan 2003 14:04:52 -0500
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:1548 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S267913AbTAHTEv>;
	Wed, 8 Jan 2003 14:04:51 -0500
Subject: Re: tenth post about PCI code, need help
From: Ray Lee <ray-lk@madrabbit.org>
To: root@chaos.analogic.com
Cc: fretre3618@hotmail.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042053204.850.931.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 08 Jan 2003 11:13:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 10:49, Richard B. Johnson wrote:
> The problem is that he's discovered something that's not supposed
> to be in the code. Only 32-bit accesses are supposed to be made to
> the PCI controller ports.

<shrug> Okay, I withdraw my interpretation. Since I had to rewrite
arch/ppc/kernel/qspan_pci.c recently, I felt mildly qualified to offer
an opinion, but obviously I was wrong :-).

Ray

