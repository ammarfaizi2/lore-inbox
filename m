Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284387AbRLDOls>; Tue, 4 Dec 2001 09:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283072AbRLDMM3>; Tue, 4 Dec 2001 07:12:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283054AbRLDMMU>; Tue, 4 Dec 2001 07:12:20 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 4 Dec 2001 12:19:31 +0000 (GMT)
Cc: esr@thyrsus.com, kaos@ocs.com.au (Keith Owens),
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <10297.1007463859@redhat.com> from "David Woodhouse" at Dec 04, 2001 11:04:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BEXr-0001vG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it not possible to write an automatic conversion tool that reads the 
> existing CML1 files and outputs CML2 rules with identical behaviour?

Bad ones - yes. Its also possible to do everything CML2 does with the CML1
ruleset. All the information required is there. Howeve CML1 (all 4 dialects
of it) is pretty ugly
