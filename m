Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266837AbSL3KbO>; Mon, 30 Dec 2002 05:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbSL3KbO>; Mon, 30 Dec 2002 05:31:14 -0500
Received: from [81.2.122.30] ([81.2.122.30]:46852 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266837AbSL3Kaz>;
	Mon, 30 Dec 2002 05:30:55 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212301038.gBUAcZWw000609@darkstar.example.net>
Subject: Re: kernel compilation: pls send cc to me
To: joshk@ludicrus.ath.cx (Joshua M. Kwan)
Date: Mon, 30 Dec 2002 10:38:35 +0000 (GMT)
Cc: abacus_an@yahoo.co.in, linux-kernel@vger.kernel.org
In-Reply-To: <20021230103025.GA13892@localhost> from "Joshua M. Kwan" at Dec 30, 2002 02:30:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel is meant to be very portable anyway.

Not really.  The kernel is designed to compiled with a specific
compiler.  A GCC version other than the recommended version might
uncover bugs that should be fixed anyway, but it might also break
things that are worked around for the recommended GCC version.

John.
