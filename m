Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVIGLwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVIGLwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIGLwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:52:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751171AbVIGLwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:52:44 -0400
Date: Wed, 7 Sep 2005 04:50:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marko Kohtala <marko.kohtala@gmail.com>
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 00/10] parport: ieee1284 fixes and cleanups
Message-Id: <20050907045052.508a0b4f.akpm@osdl.org>
In-Reply-To: <9cfa10eb050907043443325b89@mail.gmail.com>
References: <20050905183109.284672000@kohtala.home.org>
	<20050907023159.15352a82.akpm@osdl.org>
	<9cfa10eb050907043443325b89@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Kohtala <marko.kohtala@gmail.com> wrote:
>
> > You just sent ten patches, all with the same name.  This causes me grief
>  > (See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, section 2a).
> 
>  I used "quilt mail" to send those patches and it seems it requires
>  some additional trick I did not notice to make the patches have
>  different subjects.

I complained to the quilt guys about that and they did make a move to fix
it, but I recall not being very happy with the proposal.  Anyway, make sure
you have the latest version and check the documentation - it's in there
somewhere.

As a last resort, put the title into the first line of the changelog and
I'll cut-n-paste it.

>  that part. I also had picked somewhere the idea that having same
>  subject helped group the patches.
> 
>  > I now need to invent names for your patches, and if I later refer to one of
>  > them you won't know which one I'm talking about.  Oh well.
> 
>  I can also resend the patches to you. I understand you have a lot to
>  do already and I want to be of help, not burden.

Is OK, I'll work something out.
