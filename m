Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135923AbRDTN5L>; Fri, 20 Apr 2001 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135922AbRDTN45>; Fri, 20 Apr 2001 09:56:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27397 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135923AbRDTN4k>; Fri, 20 Apr 2001 09:56:40 -0400
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
To: esr@thyrsus.com
Date: Fri, 20 Apr 2001 14:43:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        willy@ldl.fc.hp.com (Matthew Wilcox),
        james.rich@m.cc.utah.edu (james rich), linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
In-Reply-To: <20010420093538.A5525@thyrsus.com> from "Eric S. Raymond" at Apr 20, 2001 09:35:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qbCT-0001IF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > I have for one. Its definitely the wrong approach to bomb Linus with patches
> > when doing the merge of an architecture. All the architecture folk with in
> > their own trees for good reason.
> 
> On the other hand, Linus has objected to the One-Big-Patch approach in
> the past with respect to things like the networking and VM code.  How
> are people to know what the right thing is?

Who said anything about one big patch ?

Just because you have a lot of differences doesnt mean you send Linus one giant
splat of code. I don't send Linus -ac for example.

Alan



