Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSF0BYC>; Wed, 26 Jun 2002 21:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSF0BYB>; Wed, 26 Jun 2002 21:24:01 -0400
Received: from dc-mx13.cluster1.charter.net ([209.225.8.23]:60107 "EHLO
	dc-mx13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S316751AbSF0BYA>; Wed, 26 Jun 2002 21:24:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Cory Watson <gphat@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add KERN_* constants to printk()s
Date: Wed, 26 Jun 2002 20:25:03 -0500
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com
References: <auto-000059811429@dc-mx08.cluster1.charter.net>
In-Reply-To: <auto-000059811429@dc-mx08.cluster1.charter.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <auto-000061790465@dc-mx13.cluster1.charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, this is for 2.5.24...

On Wednesday 26 June 2002 08:19 pm, Cory Watson wrote:
> From Kernel-Janitor todo, make sure printk() calls have the appropriate
> KERN_* constant.  These are only from the kernel/ subdir.
>
> Some of these might be off by a level, but I gave them the level that
> looked appropriate.  If this is accepted, I'll do more of them.  This is a
> good excercise for newbies like myself ;)
>
> Thanks

-- 
Cory 'G' Watson
+ Hack, lest ye rust.
