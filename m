Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272335AbTG3Xc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTG3Xc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:32:56 -0400
Received: from waste.org ([209.173.204.2]:46250 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272335AbTG3Xbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:31:44 -0400
Date: Wed, 30 Jul 2003 18:31:29 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
Message-ID: <20030730233129.GL6049@waste.org>
References: <20030730205935.GA238@elf.ucw.cz> <200307302111.h6ULBci06803@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307302111.h6ULBci06803@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 05:11:38PM -0400, Alan Cox wrote:
> > I had some strange fs corruption, and andi suggested that it probably
> > is TASKFILE-related. Perhaps this is good idea?
> 
> Well without taskfile multimode may corrupt your disks, so pick one.
> This needs debugging not paranoia.
> 
> > +	  It is safe to say Y to this question, but you should attach
> > +	  scratch monkey, first.
> 
> "a scratch monkey" - also a lot of people won't get the reference

And some that do might not appreciate it.
 
-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
