Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263752AbSITWay>; Fri, 20 Sep 2002 18:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263811AbSITWay>; Fri, 20 Sep 2002 18:30:54 -0400
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:29458 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S263752AbSITWay>; Fri, 20 Sep 2002 18:30:54 -0400
Date: Fri, 20 Sep 2002 23:36:00 +0100 (BST)
From: Guido Arenstedt <ga200@doc.ic.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Hyperthreading in -ac series
Message-ID: <Pine.LNX.4.42.0209202323530.23572-100000@faya.doc.ic.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hyperthreading does not seem to work in the -ac series
it works fine with a stock 2.4.19 kernel

during bootup i only get the message:
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.

or is this done on purpose?

