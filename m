Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265017AbSKANgt>; Fri, 1 Nov 2002 08:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265018AbSKANgt>; Fri, 1 Nov 2002 08:36:49 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29831 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265017AbSKANgj>; Fri, 1 Nov 2002 08:36:39 -0500
Subject: Re: display anomaly when switching between X and virtual terminals
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael <mohr@temerity.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210311945570.9398-100000@zeus.temerity.net>
References: <Pine.LNX.4.44.0210311945570.9398-100000@zeus.temerity.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 14:02:32 +0000
Message-Id: <1036159352.12551.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 03:54, Michael wrote:
> consoles, only when going back to X.  What I wanted to know is if this
> behavious is a result of some sort of hardware damage or if it is a
> problem with the kernel and/or X.  It's not that important, I was just
> wondering if I should be worried.

Its just the display being drawn before the colours are all restored

