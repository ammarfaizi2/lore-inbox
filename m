Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263176AbTDBWI1>; Wed, 2 Apr 2003 17:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbTDBWI1>; Wed, 2 Apr 2003 17:08:27 -0500
Received: from 66-133-183-62.br1.fod.ia.frontiernet.net ([66.133.183.62]:2759
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id <S263176AbTDBWI0>; Wed, 2 Apr 2003 17:08:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Russell Miller <rmiller@duskglow.com>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: subsystem crashes reboot system?
Date: Wed, 2 Apr 2003 16:11:16 -0600
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200304021149.36511.rmiller@duskglow.com> <200304021551.04659.rmiller@duskglow.com> <20030402141342.27c28d01.akpm@digeo.com>
In-Reply-To: <20030402141342.27c28d01.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304021611.16513.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed April 2 2003 4:13 pm, Andrew Morton wrote:

> Yes, that would probably be OK.  It won't make anything worse than it
> already is.
>
> hm, the kernel used to panic if schedule() was called from in_interrupt(),
> but that seems to have been taken out.   It's easy enough (and free) to
> put back in.

I'll see about writing a patch if you would like.  Sounds like a good thing to 
get my feet wet with.

--Russell
