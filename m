Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292153AbSBOVdb>; Fri, 15 Feb 2002 16:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292157AbSBOVdL>; Fri, 15 Feb 2002 16:33:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292156AbSBOVdI>; Fri, 15 Feb 2002 16:33:08 -0500
Subject: Re: Disgusted with kbuild developers
To: esr@thyrsus.com
Date: Fri, 15 Feb 2002 21:47:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        arjan@pc1-camc5-0-cust78.cam.cable.ntl.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020215155946.B14083@thyrsus.com> from "Eric S. Raymond" at Feb 15, 2002 03:59:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bqC7-0004Mj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Pretty much all of it. I wrote a proof of concept parser that can deduce
> > the set of rules that must be enforced and what must be changed when you
> > hit an option
> 
> Alan.  It didn't work.  It couldn't have -- among other things, the old
> language can't tell visibility from implication.

The prototype generates a very convincing table set, and the tables generate
very convincing graphs. The information to work out what option needs another
as I've said for months
