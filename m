Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbRE3LPJ>; Wed, 30 May 2001 07:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262738AbRE3LPA>; Wed, 30 May 2001 07:15:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27666 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262734AbRE3LOt>; Wed, 30 May 2001 07:14:49 -0400
Subject: Re: Generating valid random .configs
To: ankry@green.mif.pg.gda.pl
Date: Wed, 30 May 2001 12:11:58 +0100 (BST)
Cc: arjanv@redhat.com, anuradha@gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <200105300929.LAA02627@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at May 30, 2001 11:29:42 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1553tP-0005pU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2 months since I last did that, so I should do it again soon..
> 
> Some things cannot be properly fixed in CML1.
>   "$CONFIG_BINFMT_MISC" = "y" -a "$CONFIG_PROC_FS" = "n"
> is a good example.

Thats a tool not a language limit.

Alan

