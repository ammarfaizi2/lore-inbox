Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135912AbRDTN0m>; Fri, 20 Apr 2001 09:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbRDTN0d>; Fri, 20 Apr 2001 09:26:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13061 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135912AbRDTN0X>; Fri, 20 Apr 2001 09:26:23 -0400
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Fri, 20 Apr 2001 14:13:35 +0100 (BST)
Cc: willy@ldl.fc.hp.com (Matthew Wilcox),
        james.rich@m.cc.utah.edu (james rich),
        esr@thyrsus.com (Eric S. Raymond), linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
In-Reply-To: <200104200452.f3K4q3X07411@saturn.cs.uml.edu> from "Albert D. Cahalan" at Apr 20, 2001 12:52:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qajB-0001Dt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > we sent him every single one of those patches individually.  and we'd
> > go insane trying to keep up with what he'd taken and what he'd dropped.
> > 
> > until you've actually tried doing this, please don't attempt to criticise.
> 
> Have _you_ tried? If I recall correctly, Linus spoke out against the

I have for one. Its definitely the wrong approach to bomb Linus with patches
when doing the merge of an architecture. All the architecture folk with in
their own trees for good reason.

Once the code is in a fit state to merge (ie actually works well with the new
2.4.x stuff and 2.4.x core stops shifting around) then the merge can get done
piece by piece.

