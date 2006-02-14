Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWBNSy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWBNSy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWBNSy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:54:28 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:42635 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030479AbWBNSy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:54:28 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 19:53:09 +0100
To: jengelh@linux01.gwdg.de, hpa@zytor.com
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       drepper@redhat.com, austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
Message-ID: <43F22715.nailCA21DKUP@burner>
References: <43EEACA7.5020109@zytor.com>
 <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
 <43F09320.nailKUSI1GXEI@burner>
 <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr>
 <43F1F2C2.nailMWZGOQDYR@burner>
 <Pine.LNX.4.61.0602141907030.32490@yvahk01.tjqt.qr>
 <43F21D84.8010907@zytor.com>
In-Reply-To: <43F21D84.8010907@zytor.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:

> >>>>Do you have a better proposal for naming the interfaces?
> >>>
> >>>chownfn maybe. (fd + name)
> >>
> >>I am not shure if this would match the rules from the Opengroup.
> >>Solaris has these interfaces since at least 5 years.
...

> FWIW, I think the -at() suffix is just fine, and well established by now 
> (yes, there is shmat, but the SysV shared memory interfaces are bizarre 
> to begin with -- hence POSIX shared memory which has real names.)
>
> What I object to is the random, meaningless and misleading application 
> of the f- suffix.

This is what I would concur.

I could live with the meaningless f- prefixes being removed for the POSIX
variant of the interface.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
