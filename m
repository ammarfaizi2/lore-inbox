Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVDRT10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVDRT10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDRT10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:27:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:49851 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262176AbVDRT0i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:26:38 -0400
Date: Mon, 18 Apr 2005 21:29:36 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] procfs privacy: /proc/bus/pci
In-Reply-To: <1113849197.17341.52.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0504182128220.2480@dragon.hyggekrogen.localhost>
References: <1113849197.17341.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Lorenzo Hernández García-Hierro wrote:

> This patch changes the permissions of the /proc/bus/pci directory entry,
> so, non-root users are restricted of accessing it's content.
> It's also available at:
> http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_drivers_pci_
> proc.c.patch
> -- 
> Lorenzo Hernández García-Hierro <lorenzo@gnu.org> 
> [1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]
> 
> 
> begin 600 proc-privacy-1_drivers_pci_proc.c.patch
> M9&EF9B`M<'5.(&1R:79E<G,O<&-I+W!R;V,N8WYP<F]C+7!R:79A8WDM,2!D
> M<FEV97)S+W!C:2]P<F]C+F,-"BTM+2!L:6YU>"TR+C8N,3$O9')I=F5R<R]P
> M8VDO<')O8RYC?G!R;V,M<')I=F%C>2TQ"3(P,#4M,#0M,3<@,3<Z-3`Z-#DN
[snip]

Please send patches inline in emails. Not uuencoded, not as attachments, 
just plain inline text.


-- 
Jesper Juhl


