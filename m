Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVALU7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVALU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVALUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:54:43 -0500
Received: from smtp.terra.es ([213.4.129.129]:25899 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S261402AbVALUvf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:51:35 -0500
Date: Wed, 12 Jan 2005 21:51:57 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Andrew Morton <akpm@osdl.org>
Cc: miklos@szeredi.hu, kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [fuse-devel] Merging?
Message-Id: <20050112215157.1ebe872d.diegocg@teleline.es>
In-Reply-To: <20050112110109.6a21fae5.akpm@osdl.org>
References: <loom.20041231T155940-548@post.gmane.org>
	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>
	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu>
	<20050112110109.6a21fae5.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 12 Jan 2005 11:01:09 -0800 Andrew Morton <akpm@osdl.org> escribió:

> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> >  Well, there doesn't seem to be a great rush to include FUSE in the
> >  kernel.  Maybe they just don't realize what they are missing out on ;)
> 
> heh.  What userspace filesystems have thus-far been developed, and what are
> people using them for?

I know of several gmailfs users (mount your 1GB-space gmail account an use it
to get put things and retrieve them anywhere)

(If it gets into mainline people will probably stop developing things for
gnome-vfs/kioslave and use FUSE instead for "desktops")
