Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbTFZDzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 23:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265411AbTFZDzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 23:55:21 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:33997 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265407AbTFZDzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 23:55:19 -0400
Date: Thu, 26 Jun 2003 00:06:36 -0400
From: rmoser <mlmoser@comcast.net>
Subject: 2.4.21 pooched?
To: linux-kernel@vger.kernel.org
Message-id: <200306260006360780.0086B340@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having serious issues with 2.4.21.  It seems it doesn't like
ide-scsi, but panics/oops'es (something, it freezes afterwards
and blinks my kb) in ide-iops.c somewhere (ZIP/CDRW on
ide-scsi).  Also, the USB code seems to crash the system all
the time.  Gnome2 can't even begin to load, and when I kill X,
it takes the system down with it.

Everything I do is stable and safe in 2.4.18 through 2.4.20.  I
have had absolutely no panics or oopses until now with 2.4
series kernels.  I believe that the 2.4.21 kernel may be pooched.
Check that out if you haven't already heard of it.

By the way, some people tell me 2.4.21 is stable, and others
(more of 'em) tell me it's evil.  I dunno, play with it.

--Bluefox Icy

