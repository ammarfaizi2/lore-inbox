Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135927AbRDTODM>; Fri, 20 Apr 2001 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135924AbRDTODA>; Fri, 20 Apr 2001 10:03:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29701 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135927AbRDTOCr>; Fri, 20 Apr 2001 10:02:47 -0400
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
To: esr@thyrsus.com
Date: Fri, 20 Apr 2001 15:03:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        willy@ldl.fc.hp.com (Matthew Wilcox),
        james.rich@m.cc.utah.edu (james rich), linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
In-Reply-To: <20010420095302.A5674@thyrsus.com> from "Eric S. Raymond" at Apr 20, 2001 09:53:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qbV6-0001KI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, so maybe I'm being stupid.  But the implication of this talk of separate
> port trees and architecture merges is that these guys periodically send big
> resync patches to you and Linus.
> 
> If that's not what's going on, what is?

People send batches of small fixes to Linus or to me. So for example the S/390
folks send me things like 'fix the mm layer to match the changes in 2.4.3'
and 'Update the DASD storage driver'. Each of which fixes one thing or one
set of things and is easy to check on its own

