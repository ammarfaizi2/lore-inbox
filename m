Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbRDMXns>; Fri, 13 Apr 2001 19:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDMXnk>; Fri, 13 Apr 2001 19:43:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7951 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132414AbRDMXnU>; Fri, 13 Apr 2001 19:43:20 -0400
Subject: Re: New SYM53C8XX driver in 2.4.3-ac5 FIXES CD Writing!!!!
To: grantma@anathoth.gen.nz (Matthew Grant)
Date: Sat, 14 Apr 2001 00:44:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        grantma@anathoth.gen.nz (Matthew Grant), linux-kernel@vger.kernel.org
In-Reply-To: <E14oD8K-0002oj-00@zion.int.anathoth.gen.nz> from "Matthew Grant" at Apr 14, 2001 11:37:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oDFI-0003or-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> A core kernel developer  NEEDS to get these features straightened out properly 
> in a clean fashion.  People WANT reiserfs integrated and working with LVM and 

Note _clean_

> It does not look like that much work is needed to fix the stuff the base kernel
> and get better integration of these features.  The rough edges on them make us 
> look like a bunch of amatuers.

Lots of work needs doing. The entire quota code needs rewriting and that won't
happen until 2.5. The reiser+nfs stuff is probably also 2.5

> Alan, will you look into it as a project???

Not interested. Now is stabilizing time, not stuffing crap into the kernel tree
time. Vendors can (and will) ship stuff which is workable but not clean, and
they will hopefully over time fix up the stuff they care about and submit it.

Alan

