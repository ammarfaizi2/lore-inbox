Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268493AbTCABsh>; Fri, 28 Feb 2003 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268495AbTCABsh>; Fri, 28 Feb 2003 20:48:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63125
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268493AbTCABsg>; Fri, 28 Feb 2003 20:48:36 -0500
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046487638.21429.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 01 Mar 2003 03:00:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 01:30, Pavel Roskin wrote:
> In my opinion, the problem with IRQ routing on PCI-to-PCMCIA bridges is a
> major problem that needs to be addressed in 2.4 series.  Linux
> distributors who chose to use kernel PCMCIA (e.g. Red Hat) should be
> interested in working PCMCIA support.  I cannot count how many times I
> asked Red Hat users to recompile the kernel without PCMCIA support when
> they wrote me about IRQ problems.

Lets tyr it in -ac and see what cooks

