Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265568AbUAZWbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbUAZWbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:31:49 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:52870 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S265568AbUAZWbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:31:48 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16405.38217.885428.389861@jik.kamens.brookline.ma.us>
Date: Mon, 26 Jan 2004 17:31:37 -0500
To: Ulrich Schenck <schenck@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: usblp.c: usblp0: nonzero read/write bulk status received
In-Reply-To: <E1AlEOU-0000cj-00@castle>
References: <E1AlEOU-0000cj-00@castle>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The consensus of the messages I've seen on this topic seem to suggest
that you need to try using a shorter USB cable.  Even valid cables of
the legal length seem to cause this problem for some printers where
shorters cables don't.

  jik
