Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284850AbRLEXt2>; Wed, 5 Dec 2001 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284864AbRLEXtV>; Wed, 5 Dec 2001 18:49:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284861AbRLEXtH>; Wed, 5 Dec 2001 18:49:07 -0500
Subject: Re: Loadable drivers  [was  SMP/cc Cluster description ]
To: ak@suse.de (Andi Kleen)
Date: Wed, 5 Dec 2001 23:56:23 +0000 (GMT)
Cc: erich@uruk.org, linux-kernel@vger.kernel.org
In-Reply-To: <p738zch8kix.fsf@amdsim2.suse.de> from "Andi Kleen" at Dec 05, 2001 09:44:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Blto-00081l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The solution that is tried in Linux land to avoid the "buggy drivers" ->
> "linux going to windows levels of stability" trap is to keep drivers in tree
> and aggressively auditing them; trying to fix their bugs.

We need to teach Linus about "taste" in drivers. His core code taste is
impeccable, but I'm not fond of his driver taste ;)

Alan (currently cleaning up NCR5380)

