Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274424AbRJEXM4>; Fri, 5 Oct 2001 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274455AbRJEXMu>; Fri, 5 Oct 2001 19:12:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44043 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274424AbRJEXMF>; Fri, 5 Oct 2001 19:12:05 -0400
Subject: Re: Context switch times
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sat, 6 Oct 2001 00:17:35 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidel@xmailserver.org (Davide Libenzi),
        george@mvista.com (george anzinger),
        bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0110051611310.1523-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Oct 05, 2001 04:16:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15peDn-0007ze-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, i mean T = (Tstart - Tend) where :
> 
> Tstart = time the current ( prev ) task has been scheduled
> Tend   = current time ( in schedule() )
> 
> Basically it's the total time the current ( prev ) task has had the CPU

Ok let me ask one question - why ?
