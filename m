Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTIWRQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIWRQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:16:37 -0400
Received: from lucidpixels.com ([66.45.37.187]:47567 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261917AbTIWRQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:16:36 -0400
Date: Tue, 23 Sep 2003 13:16:35 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.22 ide-scsi problem.
Message-ID: <Pine.LNX.4.58.0309231315120.11291@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While executing two parallel burns, when one goes to finalize the disc,
the other one barfs (each drive = Plextor 12/10/32a (buffer underrun
protection)).

This has never occured with 2.4.[0-21].

What happened in 2.4.22 with IDE-SCSI/IDE stuff?


