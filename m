Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSKADsP>; Thu, 31 Oct 2002 22:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265571AbSKADsP>; Thu, 31 Oct 2002 22:48:15 -0500
Received: from ppp-66-63-134-18.sndg-pm4-2.dialup.nethere.net ([66.63.134.18]:36248
	"EHLO zeus.temerity.net") by vger.kernel.org with ESMTP
	id <S265446AbSKADsO>; Thu, 31 Oct 2002 22:48:14 -0500
Date: Thu, 31 Oct 2002 19:54:33 -0800 (PST)
From: Michael <mohr@temerity.net>
To: linux-kernel@vger.kernel.org
Subject: display anomaly when switching between X and virtual terminals
Message-ID: <Pine.LNX.4.44.0210311945570.9398-100000@zeus.temerity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linux-kernel et al:

I have a relatively simple question (I think).  Today I brought my Toshiba
Satellite to work, and in transit it took a few shakes.  When I brought it
home this evening, I noticed some strange behaviour.  I keep my email on
my internet gateway and ssh to it when I want to read it.  I prefer using
the true console and not the kterm, as it allows for better reading.  For
the first time tonight, I noticed that when switching between the
consoles and X, the white text momentarily turns an aqua green before the
display is redrawn.  This does not happen when switching between the 6
consoles, only when going back to X.  What I wanted to know is if this
behavious is a result of some sort of hardware damage or if it is a
problem with the kernel and/or X.  It's not that important, I was just
wondering if I should be worried.

Thanks in advance,

Michael Mohr

