Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267746AbTAaKDy>; Fri, 31 Jan 2003 05:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267747AbTAaKDy>; Fri, 31 Jan 2003 05:03:54 -0500
Received: from soul.helsinki.fi ([128.214.3.1]:31760 "EHLO soul.helsinki.fi")
	by vger.kernel.org with ESMTP id <S267746AbTAaKDx>;
	Fri, 31 Jan 2003 05:03:53 -0500
Date: Fri, 31 Jan 2003 12:13:18 +0200 (EET)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.helsinki.fi
To: linux-kernel@vger.kernel.org
Subject: .config-parameter CONFIG_ALPHA_EV6(7)
Message-ID: <Pine.OSF.4.51.0301311204470.80325@soul.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All!

A short question:

Configuring an Alpha-kernel (2.4.21-pre4) with 'make config' and
selecting CONFIG_ALPHA_EV67 (after CONFIG_ALPHA_DP264) leaves both
CONFIG_ALPHA_EV6 and CONFIG_ALPHA_EV67 defined. Is this the right
behaviour?

A new 'make config' with both above defined defaults to "N" for
CONFIG_ALPHA_EV67.

Have a nice day,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/
