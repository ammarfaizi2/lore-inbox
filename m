Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUBAUor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUBAUor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:44:47 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:17384 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265369AbUBAUoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:44:30 -0500
Date: Sun, 1 Feb 2004 22:44:12 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi
To: linux-kernel@vger.kernel.org
Subject: ifconfig question
Message-ID: <Pine.LNX.4.44.0402012241430.6206-100000@midi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again list,
I have another question too, this is about the ifconfig bit counter.
Myself I use a patch for it to not restart at 4GB (?).
is it meant to restart at that position or don't anyone care to expand the
limit to some higher values?

	Markus

