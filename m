Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283652AbRLDOob>; Tue, 4 Dec 2001 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283123AbRLDOmr>; Tue, 4 Dec 2001 09:42:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283087AbRLDMP0>; Tue, 4 Dec 2001 07:15:26 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: esr@thyrsus.com
Date: Tue, 4 Dec 2001 12:22:39 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), kaos@ocs.com.au (Keith Owens),
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011204065212.A10990@thyrsus.com> from "Eric S. Raymond" at Dec 04, 2001 06:52:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BEat-0001w7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, the syntax of CML1 is rebarbative, and its imperative 
> semantics cannot be mechanically translated to CML2's declarative 
> semantics by any means I'm aware of.

The dependancy tree from CML1 is not that hard to obtain. It's not quite
complete or correct though
