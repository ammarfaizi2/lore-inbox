Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWHWVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWHWVAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWHWVAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:00:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:24300 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965002AbWHWVAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:00:43 -0400
Message-ID: <44ECC1EF.2020802@fr.ibm.com>
Date: Wed, 23 Aug 2006 23:00:31 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru>
In-Reply-To: <44EC31FB.2050002@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>
> [ ... ]
>
> Patch set is applicable to 2.6.18-rc4-mm2

Applying patch 1_6_BC_kconfig.patch
patching file arch/i386/Kconfig
Hunk #1 succeeded at 1184 with fuzz 2 (offset 38 lines).
patching file arch/ia64/Kconfig
Hunk #1 succeeded at 505 with fuzz 2 (offset 24 lines).
patching file arch/i386/Kconfig
Hunk #1 succeeded at 1186 with fuzz 2 (offset 40 lines).
patching file arch/ia64/Kconfig
Hunk #1 succeeded at 507 with fuzz 2 (offset 26 lines).
patching file arch/powerpc/Kconfig
Hunk #1 succeeded at 1040 with fuzz 2 (offset 2 lines).
patching file arch/ppc/Kconfig
Hunk #1 succeeded at 1416 with fuzz 2 (offset 2 lines).
patching file arch/sparc/Kconfig
Hunk #1 FAILED at 296.
1 out of 1 hunk FAILED -- rejects in file arch/sparc/Kconfig
patching file arch/sparc64/Kconfig
Hunk #1 FAILED at 432.
1 out of 1 hunk FAILED -- rejects in file arch/sparc64/Kconfig
patching file arch/x86_64/Kconfig
Hunk #1 FAILED at 655.
1 out of 1 hunk FAILED -- rejects in file arch/x86_64/Kconfig
patching file kernel/bc/Kconfig
patching file arch/powerpc/Kconfig
Hunk #1 succeeded at 1042 with fuzz 2 (offset 4 lines).
patching file arch/ppc/Kconfig
Hunk #1 succeeded at 1418 with fuzz 2 (offset 4 lines).
patching file arch/sparc/Kconfig
Hunk #1 FAILED at 296.
1 out of 1 hunk FAILED -- rejects in file arch/sparc/Kconfig
patching file arch/sparc64/Kconfig
Hunk #1 FAILED at 432.
1 out of 1 hunk FAILED -- rejects in file arch/sparc64/Kconfig
patching file arch/x86_64/Kconfig
Hunk #1 FAILED at 655.
1 out of 1 hunk FAILED -- rejects in file arch/x86_64/Kconfig
patching file kernel/bc/Kconfig
Patch 1_6_BC_kconfig.patch does not apply (enforce with -f)

C.
