Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272767AbTHSR0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272871AbTHSRI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:08:28 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:51586 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S272851AbTHSQ5z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:57:55 -0400
From: jjluza <jjluza@yahoo.fr>
To: Valdis.Kletnieks@vt.edu
Subject: Re: problem with test3-mm3 and nvidia drivers
Date: Tue, 19 Aug 2003 18:58:05 +0200
User-Agent: KMail/1.5.3
References: <200308191536.53124.jjluza@yahoo.fr> <200308191630.h7JGUEVq004537@turing-police.cc.vt.edu>
In-Reply-To: <200308191630.h7JGUEVq004537@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308191858.05315.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 19 Août 2003 18:30, vous avez écrit :
> On Tue, 19 Aug 2003 15:36:53 +0200, jjluza <jjluza@yahoo.fr>  said:
> > I try to compile nvidia drivers (closed sources) with test3-mm3 but it
> > doesn't work anymore.
>
> Nevermind, known problem..  That will teach me not to check first. ;)
>
> > I will warn the nvidia patch maintainer (minion.de) about it.
>
> They know, there's a patch for -test3-bk5 should Just Work for -mm3.
>
> Linux 2.5 (2.5.75, 2.6.0-test2) updated 08/18/2003
>
> This patch is the 1.0-4496 equivalent of the 1.0-4363 patch, the same
> installation instructions and comments apply. If you experience problems
> with this patch, please let me know.
>
> In Linux 2.6.0-test3-bk5, PCI names related data structures were changed
> again, you will need to apply the incremental patch below to make the
> driver build on this kernel. The patch is trivial, if you are using another
> driver release, you shouldn't have trouble porting the change. Download:
>
> NVIDIA_kernel-1.0-4496-2.5.diff
> NVIDIA_kernel-1.0-4496-2.6-bk5.diff


thanks a lot, I try that

