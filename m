Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRDTUzH>; Fri, 20 Apr 2001 16:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDTUy5>; Fri, 20 Apr 2001 16:54:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131625AbRDTUyq>; Fri, 20 Apr 2001 16:54:46 -0400
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
To: esr@thyrsus.com
Date: Fri, 20 Apr 2001 21:55:14 +0100 (BST)
Cc: willy@ldl.fc.hp.com (Matthew Wilcox), linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
In-Reply-To: <20010420154743.A19618@thyrsus.com> from "Eric S. Raymond" at Apr 20, 2001 03:47:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qhvx-0002BR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_BINFMT_SOM: arch/parisc/config.in arch/parisc/defconfig
> Not used in code anywhere.  Can you get rid of this one?

Its used in the parisc tree as are most of the others you see. You probably want
to simply skip processing arch/parisc

