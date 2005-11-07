Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVKGN7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVKGN7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVKGN7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:59:51 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:53048 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S964819AbVKGN7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:59:50 -0500
X-ME-UUID: 20051107135949637.9B9301C00216@mwinf0512.wanadoo.fr
Subject: Re: 3D video card recommendations
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1131373462.11265.12.camel@localhost.localdomain>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <1131373462.11265.12.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131371981.3340.146.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 07 Nov 2005 14:59:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 15:24, Alan Cox wrote:
> On Llu, 2005-11-07 at 07:42 -0500, Steven Rostedt wrote:
> > Are there good 3D cards that don't depend on a proprietary module, that
> > can run on a AMD64 board?  That was pretty much my questing to begin
> > with :)
> 
> Some of the radeons - R3xx is pretty close to usable R2xx works well.
> Support for running 32bit hardware accelerated apps on 64bit kernel
> recently went in.

I'm using a Radeon 9600 (R350) with debian packages (32bits userspace,
64bits kernel) since a few weeks, and it works very well, apart from a
few visual glitches here and there (the only GL apps I use are some free
games, blender and some screensavers). The only thing I had to recompile
was the drm moduleset.

	xav


