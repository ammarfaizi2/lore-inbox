Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265989AbTGDLbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbTGDLbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:31:44 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:44218 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S265989AbTGDLbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:31:43 -0400
Date: Fri, 4 Jul 2003 13:46:08 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Ben Collins <bcollins@debian.org>
Subject: Re: [Linux-fbdev-devel] Re: New fbdev updates.
Message-ID: <20030704114608.GB1085@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org> <20030703235039.GB502@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703235039.GB502@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Jul 03, 2003 at 07:50:39PM -0400, Ben Collins ha scritto: 
> >    I have updates to the framebuffer layer. Alot of bug fixes accumlated. 
> > A couple of driver updates as well. I have more code to go in but haven't 
> > had time to add them in. Please test. This is not the final code going in 
> > just yet. More needs to be done. The patches are at the usual
> 
> Seems my old corrupt cursor is fixed, but with your new code I am
> getting ghost cursors left behind while moving around in vim over ssh
> with syntax on.

Same here. I can see the ghost cursor also when typing fast on the shell
(via ssh) and the hit backspace, arrows, home, end. I don't see it using
normal tty (the kernel is the same, I just did ssh ::1).

Btw, the cursor doesn't disappear  anymore switching back and forth from
X.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
It can't rain forever,
but you can die before seeing the sun again.
