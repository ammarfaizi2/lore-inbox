Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273419AbRIRTZ5>; Tue, 18 Sep 2001 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273418AbRIRTZp>; Tue, 18 Sep 2001 15:25:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273419AbRIRTZi>; Tue, 18 Sep 2001 15:25:38 -0400
Subject: Re: ANN: syscalltrack version 0.60 released
To: mulix@actcom.co.il (mulix)
Date: Tue, 18 Sep 2001 20:30:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, choo@actcom.co.il
In-Reply-To: <Pine.LNX.4.33.0109182157020.18755-100000@alhambra.merseine.nu> from "mulix" at Sep 18, 2001 10:11:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jQZy-0001aw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The syscalltrack project is looking for developers, both for kernel
> space and user space. If you want to join in on the fun, get in touch
> with us on the 'syscalltrack-hackers' mailing list
> (http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

You might want to take a look at the lsm patches, they are intended to
add a generic security frame work to Linux. Now its designed for doing
heavy stuff like the NSA security module it ought to be enough to do
tracking stuff, and to fit cleaning into that modular infrastructure
