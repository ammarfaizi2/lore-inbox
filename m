Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRC0ESY>; Mon, 26 Mar 2001 23:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbRC0ESO>; Mon, 26 Mar 2001 23:18:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57616 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130515AbRC0ER4>; Mon, 26 Mar 2001 23:17:56 -0500
Subject: Re: "mount -o loop" lockup issue
To: dek_ml@konerding.com (David Konerding)
Date: Tue, 27 Mar 2001 05:19:09 +0100 (BST)
Cc: jmadden@spock.shacknet.nu (Jason Madden), linux-kernel@vger.kernel.org
In-Reply-To: <3AC00E05.47C264D9@konerding.com> from "David Konerding" at Mar 26, 2001 07:50:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14hkwq-0002y0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a bug in Linux 2.4.2, fixed in later versions.  Regression/quality control
> testing would
> have caught this, but the developers usually just break things and wait for people
> to complain
> as their "Regression" testers.

Hardly. We knew it was broken since well before 2.4.0. It just got a little
interesting to fix.
