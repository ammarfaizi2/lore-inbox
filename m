Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTBCCkR>; Sun, 2 Feb 2003 21:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTBCCkR>; Sun, 2 Feb 2003 21:40:17 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:25353 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265863AbTBCCkQ>; Sun, 2 Feb 2003 21:40:16 -0500
Date: Mon, 3 Feb 2003 02:49:46 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and device table support.
Message-ID: <20030203024946.GA90036@compsoc.man.ac.uk>
References: <200302012302.h11N2R3U001433@eeyore.valparaiso.cl> <20030203022709.83AA52C0A7@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203022709.83AA52C0A7@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18fWg6-000LYI-00*NuNaPonI2IM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 11:52:57AM +1100, Rusty Russell wrote:

> Well, "modprobe foo" will only give you the "new_foo" driver if (1) the
> foo driver isn't found, and (2) the new driver author decides that
> it's a valid replacement.

It's not the driver author's decision as to which module an admin would
like to use. This just seems to make things a lot more awkward.

> going to do this, I'd rather they did it in the kernel, rather than
> some random userspace program.

Can you explain why please ?

regards
john
