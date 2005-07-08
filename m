Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVGHKTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVGHKTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVGHKTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:19:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262428AbVGHKTl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:19:41 -0400
Date: Fri, 8 Jul 2005 03:18:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stelian Pop <stelian@popies.net>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
Subject: Re: GIT tree broken?
Message-Id: <20050708031857.5b1d5950.akpm@osdl.org>
In-Reply-To: <1120816858.4688.4.camel@localhost.localdomain>
References: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>
	<1120816858.4688.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:
>
> Le vendredi 08 juillet 2005 à 12:30 +0300, Meelis Roos a écrit :
>  > I'm trying to sync with 
>  > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
>  > with cogito cg-update (cogito 0.11.3+20050610-1 Debian package) and it 
>  > fails with the following error:

Upgrade to cogito-0.12.  

>  > Applying changes...
>  > error: cannot map sha1 file 043d051615aa5da09a7e44f1edbb69798458e067
>  > error: Could not read 043d051615aa5da09a7e44f1edbb69798458e067
>  > cg-merge: unable to automatically determine merge base
> 
>  I see this too, with the latest cogito git tree, reproductible even in a
>  fresh environment:

Maybe post-0.12 broke.  Try the 0.12 release.
