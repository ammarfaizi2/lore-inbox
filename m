Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272115AbRIEMES>; Wed, 5 Sep 2001 08:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRIEMEJ>; Wed, 5 Sep 2001 08:04:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272115AbRIEMDz>; Wed, 5 Sep 2001 08:03:55 -0400
Subject: Re: Linux 2.4.9-ac6
To: davids@webmaster.com (David Schwartz)
Date: Wed, 5 Sep 2001 13:07:21 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAEAPDLAA.davids@webmaster.com> from "David Schwartz" at Sep 04, 2001 08:30:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ebSj-0005ig-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> based upon whether you have the source or not. What should logically taint
> the kernel are modules that weren't compiled for that exact kernel version
> or are otherwise mismatched.

Setting a flag for the insmod -f required case as well is an extremely good
idea. This is entirely about making information available nothing else and
your suggestion there is a good one.

Alan
