Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVE0MRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVE0MRl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVE0MRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:17:40 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:43276 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262446AbVE0MRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:17:30 -0400
Date: Fri, 27 May 2005 13:17:24 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: cutaway@bellsouth.net, linux-kernel@vger.kernel.org
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
In-Reply-To: <17046.52070.257018.186057@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.61L.0505271314210.14679@blysk.ds.pg.gda.pl>
References: <000701c5628b$583f8060$2800000a@pc365dualp2>
 <17046.52070.257018.186057@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Mikael Pettersson wrote:

> The only issue AFAIK is that assemblers may only
> recognise the plain base-10 AAD syntax. No biggie.

 And actually gas has supported the explicit operand variations for "aad" 
and "aam" for a long time now.

  Maciej
