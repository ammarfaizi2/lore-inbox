Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbTCGEhX>; Thu, 6 Mar 2003 23:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbTCGEhX>; Thu, 6 Mar 2003 23:37:23 -0500
Received: from tao.ca ([216.138.216.131]:60633 "HELO dojo.tao.ca")
	by vger.kernel.org with SMTP id <S261342AbTCGEhX>;
	Thu, 6 Mar 2003 23:37:23 -0500
Date: Thu, 6 Mar 2003 23:47:51 -0500 (EST)
From: Geordie Birch <geordie@tao.ca>
To: linux-kernel@vger.kernel.org
Subject: Oops early on in 2.4.20 boot
Message-ID: <Pine.LNX.4.44.0303062341510.27659-100000@dojo.tao.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting "unable to handle kernel NULL Pointer dereference at virtual
address 00000354" (actual address varies).

This happens only with kernels I have compiled in the last few hours -
kernels made last night boot just fine (as far as I can tell the only
differences are in SCSI and Parport).

Any clues?

Geordie.

