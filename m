Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273896AbRIRUaj>; Tue, 18 Sep 2001 16:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273900AbRIRUa3>; Tue, 18 Sep 2001 16:30:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22025 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273896AbRIRUaQ>; Tue, 18 Sep 2001 16:30:16 -0400
Subject: Re: Linux 2.4.10-pre11
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Tue, 18 Sep 2001 21:33:31 +0100 (BST)
Cc: adilger@turbolabs.com (Andreas Dilger), torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20010918221748.1f51f801.skraw@ithnet.com> from "Stephan von Krawczynski" at Sep 18, 2001 10:17:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jRYh-0001iM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hm, I guess if anybody would be capable of _really_ fixing vm in upto-pre10
> state, he would have done it already. It's not that people would not have
> tried, but it looks like nobody is able to get the _whole_ picture of this.

They have been, but slowly and steadily - thats why the -ac mm worked fairly
well. Its also why merging it with Linus would have been pointless at this
time since its just backing out some of the less apparently useful
experiments
