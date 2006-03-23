Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWCWGEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWCWGEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCWGEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:04:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbWCWGEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:04:50 -0500
Date: Wed, 22 Mar 2006 22:01:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Antonino Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@linux.ie>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sylvain.meyer@worldonline.fr
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for
 intelfb
Message-Id: <20060322220121.5c402174.akpm@osdl.org>
In-Reply-To: <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
	<b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino Daplas" <adaplas@gmail.com> wrote:
>
> > The code is also available in the i915fb branch or
> > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6
> >
> > It may need more testing on the i945G, and I think adding i945GM
> > support might only be a few lines of code...
> >
> > Is there a framebuffer git tree this could go in?
> 
> There's no git tree for the framebuffer layer, I just send updates
> directly to akpm. Andrew?
> 

I added Dave's git tree to the -mm lineup.  Haven't tried fetching it
it yet though.

If you're OK with it all then Dave can ask Linus to pull it direct when
he's ready.
