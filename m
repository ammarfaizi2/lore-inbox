Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277064AbRJHSFV>; Mon, 8 Oct 2001 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277060AbRJHSFK>; Mon, 8 Oct 2001 14:05:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277052AbRJHSE6>; Mon, 8 Oct 2001 14:04:58 -0400
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
To: Martin.Bligh@us.ibm.com
Date: Mon, 8 Oct 2001 19:10:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), landley@trommello.org,
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <1811287155.1002538667@mbligh.des.sequent.com> from "Martin J. Bligh" at Oct 08, 2001 10:57:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qeqz-0001Ne-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > speculate on how the 2.4.10 vm works anyway
> 
> Can you describe why it's N! ? Are you talking about the worst possible case, 
> or a two level local / non-local problem?

Worst possible. I dont think in reality it will be nearly that bad
