Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRFRNBQ>; Mon, 18 Jun 2001 09:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRFRNBI>; Mon, 18 Jun 2001 09:01:08 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:27408 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S261254AbRFRNAz>; Mon, 18 Jun 2001 09:00:55 -0400
Date: Mon, 18 Jun 2001 09:00:52 -0400 (EDT)
From: Modular Forms Boy <eger@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
cc: eger@cc.gatech.edu
Subject: New Linux Drivers - Configure question
Message-ID: <Pine.SOL.4.21.0106180852480.16027-100000@oscar.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am working on a new framebuffer driver for an LCD controller that's
custom to the PowerPC embedded world.  As such, it's architecture
dependent.  Where should I place the driver in the tree, and how should I
set up the proper Configure options?  Where do I put checks for #ifdef
CONFIGURE_blah_blah_blah?

Yours truly,
David Eger

