Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTJZBQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 21:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJZBQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 21:16:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:40359 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262844AbTJZBQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 21:16:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 26 Oct 2003 02:16:39 +0100 (MET)
Message-Id: <UTC200310260116.h9Q1GdR00982.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: Re: Linux 2.6.0-test9
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three things:

2.6.0t9 still can leave the user with a dead keyboard
If Vojtech does not provide a better patch I suppose
you should apply my patch of a few days ago.

Within a few days two people have reported that they cannot
mount a FAT fs that 2.4 and Windows handle fine.
Probably also that should be fixed, for example with
my patch from yesterday.

I have run 2.6.0-test6 without any problems. Switched
to 2.6.0-test9 today. Something involving job control
or so is broken. Several of my remote xterms hang.
Will investigate later.

Andries
