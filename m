Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130886AbQKINns>; Thu, 9 Nov 2000 08:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQKINni>; Thu, 9 Nov 2000 08:43:38 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:11530 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130886AbQKINnY>; Thu, 9 Nov 2000 08:43:24 -0500
Message-ID: <3A0AA9F2.9F76DF1@holly-springs.nc.us>
Date: Thu, 09 Nov 2000 08:43:14 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Lars Marowsky-Bree <lmb@suse.de>, Christoph Rohland <cr@sap.com>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <E13trrP-00019n-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> RTLinux is hardly a fork. UcLinux is a fork, it has its own mailing list, web
> site and everything. Post 2.4 I'm still very interested in spending time merging
> the 2.4 uc and the main tree. I think it can be done and they are doing it in
> a way that leads logically to this.


And how would a hypothetical Advanced Linux Kernel Project be different?
Set aside the GKHI and the issue of binary-only hook modules; how would
an "enterprise" fork be any different than RT or UC? It'll go off,
change and add some things, and then perhaps be merged back in later. In
the meantime, developers who want to add "enterpriseness" to Linux will
have an outlet and won't have to simply gripe on this list anymore. And
users who want an "enterprise" kernel can get one.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
