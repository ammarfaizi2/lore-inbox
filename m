Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSBOW1B>; Fri, 15 Feb 2002 17:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292228AbSBOW0w>; Fri, 15 Feb 2002 17:26:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41489 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292230AbSBOW0r>; Fri, 15 Feb 2002 17:26:47 -0500
Subject: Re: Disgusted with kbuild developers
To: esr@thyrsus.com
Date: Fri, 15 Feb 2002 22:40:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        arjan@pc1-camc5-0-cust78.cam.cable.ntl.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020215164610.A14418@thyrsus.com> from "Eric S. Raymond" at Feb 15, 2002 04:46:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16br21-0004Vw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The prototype generates a very convincing table set, and the tables generate
> > very convincing graphs. The information to work out what option needs another
> > as I've said for months
> 
> I've *solved* this problem.  I understand the constraints.  I know 
> exactly what you will have to do to get the rest of the way, *because
> I did it*.

No you've replaced the system with one thats much harder to understand and
forces new tools on people. The *interesting* problem to solve is keeping
the existing infrastructure there and getting the same kind of results.

Since the information is there in CML1 to generate the list of constraints
for any given option, its a reasonable assertion that the entire CML2
language rewrite is self indulgence from a self confessed language invention
freak.

Alan
