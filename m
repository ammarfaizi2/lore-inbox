Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271705AbRIDPRD>; Tue, 4 Sep 2001 11:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRIDPQx>; Tue, 4 Sep 2001 11:16:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271705AbRIDPQd>; Tue, 4 Sep 2001 11:16:33 -0400
Subject: Re: Question Re AC Patch with VM Tuneable Parms for now
To: jlmales@softhome.net
Date: Tue, 4 Sep 2001 16:20:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B943CB0.14656.754C73@localhost> from "John L. Males" at Sep 04, 2001 02:30:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eI05-0003k5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can someone advise me if the "Make several vm behaviours tunable for
> now" as of the 2.4.9-ac4 patch are implemented in the kernel .config
> file?  If so is there an easy way to carry forward a 2.4.8 version of

They are in /proc

> the .config file using "make xconfig" so that I do not have to set
> all the setting I have made from scratch?  I get the sense from the

Make oldconfig
