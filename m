Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbTJASGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTJASGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:06:40 -0400
Received: from glangrak.cable.icemark.net ([62.2.156.54]:11409 "EHLO
	glangrak.internal.icemark.net") by vger.kernel.org with ESMTP
	id S263159AbTJASGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:06:37 -0400
Date: Wed, 1 Oct 2003 20:06:33 +0200 (CEST)
From: beh@icemark.net
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5 (>>2.5.62)/2.6 keyboard oddity
Message-ID: <Pine.LNX.4.58.0310011940340.13575@berenium.icemark.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since quite some time I upgraded to the latest kernel
(2.6.0-test6). Up until a few days ago, I'd been using 2.5.62
(originally needed to upgrade 2.4->2.5 for better USB palmsync
support).

Since the upgrade, I am experiencing some oddities regarding
keyboard handling - and it's definetely not a hardware problem (the
problem is there consistently in 2.6.0 and consistently NOT present
in 2.5.62).

The problem shows up like this - under X, I have a number of
keyboard bindings to start a few applications (xterm, mozilla,
pine, ...).

Since the upgrade to 2.6, sometimes, a key combination doesn't
work; or gets triggered 3 or 4 times...
Also, when the input focus is still in a text window, I see, that
sometimes, ctrl+alt don't react properly (e.g. input focus is on an
xterm - I press CTRL+ALT+m to start mozilla through a binding,
mozilla doesn't get started - instead an 'm' appears in the xterm
(showing that at least the CTRL didn't make it... ;-(


The hardware I am experencing problems with, is an IBM Thinkpad
A30p (uses standard AT keyboard drivers).


Any clue, how to fix this?



    Benedikt

PATRIOT, n.  One to whom the interests of a part seem superior to those
       of the whole.  The dupe of statesmen and the tool of conquerors.
			(Ambrose Bierce, The Devil's Dictionary)
