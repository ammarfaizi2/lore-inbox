Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314319AbSDRLfS>; Thu, 18 Apr 2002 07:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314320AbSDRLfR>; Thu, 18 Apr 2002 07:35:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17678 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314319AbSDRLfQ>; Thu, 18 Apr 2002 07:35:16 -0400
Subject: Re: SSE related security hole
To: ak@suse.de (Andi Kleen)
Date: Thu, 18 Apr 2002 12:53:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        dledford@redhat.com (Doug Ledford), jh@suse.cz,
        linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de, ak@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020418131431.B22558@wotan.suse.de> from "Andi Kleen" at Apr 18, 2002 01:14:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yATQ-0004V1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Intel folks are actually saying even back in Pentium MMX days that it isnt
> > guaranteed that the FP/MMX state are not seperate registers
> 
> In this case it would be possible to only do the explicit clear
> when the CPU does support sse1. For mmx only it shouldn't be needed.
> For sse2 also not.

Do you have a documentation cite for that claim ?
