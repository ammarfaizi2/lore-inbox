Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVAKBt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVAKBt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVAKBt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:49:58 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:62690 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262778AbVAKBtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:49:21 -0500
Date: Mon, 10 Jan 2005 17:48:57 -0800 (PST)
From: walt <wa1ter@myrealbox.com>
To: linux-kernel@vger.kernel.org
Subject: Preemptible Big Kernel Lock?
Message-ID: <20050110172910.F49234@x9.ybpnyarg>
Organization: none
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running the P-BKL all day and I've been very
happy with it so far.

I've found the machine to be very responsive and smooth
during compilation of large programs, playback of audio/
video, all the usual stuff I do on my desktop machine.

The problem is:  the same machine was also great two
days ago, before the preemptible BKL -- the best it's
been for years.  I can't tell the difference, and I
had no complaints even before this update.

Two questions:

Would I expect to see a difference on a uni-processor
machine?  (That's all I have.)

What kind of testing could I do to demonstrate the
difference?

