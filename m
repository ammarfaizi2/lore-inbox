Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270891AbRHNWLd>; Tue, 14 Aug 2001 18:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270892AbRHNWLY>; Tue, 14 Aug 2001 18:11:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270891AbRHNWLU>; Tue, 14 Aug 2001 18:11:20 -0400
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
To: esr@thyrsus.com
Date: Tue, 14 Aug 2001 23:13:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010814172733.B4772@thyrsus.com> from "Eric S. Raymond" at Aug 14, 2001 05:27:33 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WmRd-00026D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what are the implications of running in no-IOAPIC mode?  Performance loss?

Slight performance hit. For the moment Im interested to know if it helps, 
as a guess

Alan
