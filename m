Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTACWtm>; Fri, 3 Jan 2003 17:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbTACWtm>; Fri, 3 Jan 2003 17:49:42 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:34176 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S267708AbTACWtl>; Fri, 3 Jan 2003 17:49:41 -0500
Date: Fri, 3 Jan 2003 23:58:06 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_TSC_DISABLE question
Message-ID: <20030103225806.GA10646@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jan 03, 2003 at 05:52:55PM -0500, Mark Hahn wrote:

Hi Mark

> > > Depends on your box. Most standard SMP boxes are all clocked off the
> > > same clock, so it's not an issue.
> > 
> > Hi Martin
> > 
> > Thanks for your reply
> > 
> > Is there a way to verify this? or must I contact the motherboard maker and
> > ask for it? how I should ask it?
> 
> any SMP less than $50k is using a single clock to drive the CPUs,
> and therefore has TSC's in sync.  if you owned a numa/clustered
> SMP, you'd know it - they're the only ones that need something special.

Thanks for your reply

I think that CONFIG_X86_TSC_DISABLE should be more informative on this

Ulisses


                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
