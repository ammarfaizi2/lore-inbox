Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVFDBVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVFDBVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 21:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFDBVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 21:21:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:41611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261204AbVFDBVb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 21:21:31 -0400
Date: Fri, 3 Jun 2005 18:21:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: sylvain.meyer@worldonline.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-Id: <20050603182125.3735f0c7.akpm@osdl.org>
In-Reply-To: <42A0F05A.8010901@ens-lyon.org>
References: <42A0D88E.7070406@pobox.com>
	<20050603163843.1cf5045d.akpm@osdl.org>
	<42A0F05A.8010901@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton a écrit :
> > Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
> > the usual suspects.
> > 
> > Subject: intelfb crash on i845
> > Subject: Re: [Linux-fbdev-devel] intelfb crash on i845
> 
> These two entries seem to be the same one, from me.
> Sylvain Meyer was working on it. And I've recently seen some patches
> from him on the mm-commit list. I didn't have time to test them but I
> should be able to try next week (especially if a new -mm is released
> soon).
> 

OK, thanks - I'll try to get mm3 out this evening, if by some miracle some
of it compiles and boots ;)

