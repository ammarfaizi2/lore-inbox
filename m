Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265797AbUFINb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUFINb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUFINb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:31:29 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:1690 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265778AbUFINaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:30:09 -0400
Date: Wed, 9 Jun 2004 15:30:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Karsten Keil <kkeil@suse.de>
Cc: kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] weird code in some isdn drivers
Message-ID: <20040609133003.GO21168@wohnheim.fh-wedel.de>
References: <20040609123633.GH21168@wohnheim.fh-wedel.de> <20040609131628.GA10403@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040609131628.GA10403@pingi3.kke.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 15:16:28 +0200, Karsten Keil wrote:
> On Wed, Jun 09, 2004 at 02:36:33PM +0200, Jörn Engel wrote:
> > Karsten, Kai,
> > 
> > while I agree that this is a measurement bug, it's not exacly fun to
> > look at the code in question.  Can you please find a solution for
> > hscx_irq.c?
> 
> HiSax and I4L is in bugfix only mode, since it will replaced
> by other drivers. So I do not want waste time for soon obsolate code.

Valid solution.  Any date as to when the new drivers will be
available?

Jörn

-- 
To my face you have the audacity to advise me to become a thief - the worst
kind of thief that is conceivable, a thief of spiritual things, a thief of
ideas! It is insufferable, intolerable!
-- M. Binet in Scarabouche
