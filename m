Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbSJZFqo>; Sat, 26 Oct 2002 01:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSJZFqo>; Sat, 26 Oct 2002 01:46:44 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:57744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261860AbSJZFqn>;
	Sat, 26 Oct 2002 01:46:43 -0400
Message-Id: <5.1.0.14.2.20021026073915.00b55008@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 26 Oct 2002 07:49:56 +0200
To: ebiederm@xmission.com (Eric W. Biederman)
From: Mike Galbraith <efault@gmx.de>
Subject: Re: loadlin with 2.5.?? kernels
Cc: robert w hall <bobh@n-cantrell.demon.co.uk>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
In-Reply-To: <m13cqtn5cm.fsf@frodo.biederman.org>
References: <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
 <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
 <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
 <m18z0os1iz.fsf@frodo.biederman.org>
 <007501c27b37$144cf240$6400a8c0@mikeg>
 <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:20 PM 10/25/2002 -0600, Eric W. Biederman wrote:
>Mike Galbraith <efault@gmx.de> writes:
>
> > I went back and double-checked my loadlin version, and it turned out I was
> > actually using 1.6a due to a fat finger.  Version 1.6c booted fine 
> (only one
> > kernel tested) without Eric's help.  1.6a definitely needs Eric's help 
> to boot.
>
>Darn.  I guess the arguments for my patch may not be quite as good,
>but I still think it may be worth while.

Well, cleanup is always a pretty fine argument.  Since there only seem to 
be two of us loadlin users, you probably didn't loose much argument wise 
;-)  The other loadlin user reported failure at .38, so maybe your patch is 
needed sometimes even with loadlin-1.6c.  (other loadlin user listening?)

         -Mike

