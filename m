Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135627AbRDXNxa>; Tue, 24 Apr 2001 09:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135624AbRDXNwI>; Tue, 24 Apr 2001 09:52:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4364 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135616AbRDXNvA>; Tue, 24 Apr 2001 09:51:00 -0400
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
To: markus.schaber@student.uni-ulm.de (Markus Schaber)
Date: Tue, 24 Apr 2001 14:51:38 +0100 (BST)
Cc: eccesys@topmail.de (mirabilos), esr@thyrsus.com,
        cate@dplanet.ch (Giacomo A. Catenazzi),
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <3AE53B9E.1C52266C@student.uni-ulm.de> from "Markus Schaber" at Apr 24, 2001 10:38:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s3EC-00025p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, would it be possible to create some module under LGPL, and then
> have included it into the kernel? Maybe it needs to maintain the LGPL
> version out of the kernel, and transform a copy to the GPL before
> submitting?

There is kernel code under a whole variety of licenses. When linked together
the resulting work is GPL but many of the pieces used on their own or in
conjunction with different code are not GPL.

Alan
