Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJZE65>; Sat, 26 Oct 2002 00:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJZE65>; Sat, 26 Oct 2002 00:58:57 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:24173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261856AbSJZE65>;
	Sat, 26 Oct 2002 00:58:57 -0400
Message-Id: <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 26 Oct 2002 07:02:15 +0200
To: robert w hall <bobh@n-cantrell.demon.co.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: loadlin with 2.5.?? kernels
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
In-Reply-To: <ApOnXDAL8bu9EwOR@n-cantrell.demon.co.uk>
References: <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
 <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
 <m18z0os1iz.fsf@frodo.biederman.org>
 <007501c27b37$144cf240$6400a8c0@mikeg>
 <m1bs5in1zh.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:00 PM 10/25/2002 +0100, robert w hall wrote:

>Hans Lermen changed the gdt structure in version 1.6b to enable it to
>boot a win4lin-enabled kernel - he also changed things recently (1.6c)
>to boot kernels of between 0.5 &1.5Mb compressed.

(1.5MB?  I remember hitting the 1MB wall even after grabbing 1.6c.  hmm..)

I went back and double-checked my loadlin version, and it turned out I was 
actually using 1.6a due to a fat finger.  Version 1.6c booted fine (only 
one kernel tested) without Eric's help.  1.6a definitely needs Eric's help 
to boot.

(gee, it works.  sure hope I don't hit the new lard limit any time soon;)

         -Mike

