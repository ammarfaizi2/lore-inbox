Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUILVVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUILVVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUILVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:21:34 -0400
Received: from adsl-67-115-10-133.dsl.sndg02.pacbell.net ([67.115.10.133]:51616
	"EHLO rosetta.temerity.net") by vger.kernel.org with ESMTP
	id S262138AbUILVVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:21:33 -0400
Date: Sun, 12 Sep 2004 14:21:48 -0700 (PDT)
From: m.mohr@laposte.net
X-X-Sender: mohr@rosetta.temerity.net
To: linux-kernel@vger.kernel.org
Subject: possible kernel bug
Message-ID: <Pine.LNX.4.60.0409121409450.24367@rosetta.temerity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago I tried to use my Palm Visor under Linux for the first 
time.  It does work (USB file transfers with pilot-link tested), however 
after the first transfer new xterms cannot be started.  If I start say 6 
xterms before using it, they will stay open - but once they are closed 
they cannot be reopened.

I remember reading something along hte lines of vterm expansion problems 
with older 2.6 series kernels, but apparently those were fixed.  Any idea 
why this might be happening?

Please cc all replies to me off-list since I am not subscribed.

Thanks everyone!
-Michael Mohr
