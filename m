Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286370AbRLVAe5>; Fri, 21 Dec 2001 19:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286367AbRLVAer>; Fri, 21 Dec 2001 19:34:47 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:23821 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S285705AbRLVAem>; Fri, 21 Dec 2001 19:34:42 -0500
Message-Id: <4.3.2.7.2.20011221193149.00ca6f00@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 21 Dec 2001 19:34:29 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: re: Linux 2.4.17
In-Reply-To: <Pine.LNX.4.43.0112211536430.16844-100000@waste.org>
In-Reply-To: <Pine.LNX.4.21.0112211744080.7492-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:10 PM 12/21/01, Oliver Oxymoron wrote:
>On Fri, 21 Dec 2001, Marcelo Tosatti wrote:
>
>... There's always the risk of breaking something
>and you don't want to introduce a disk-eating bug between -rc and -final.
>It's better to ship one more -rc and wait a day before -final. If you
>don't, people will just get in the habit of waiting a day after -final to
>be safe.
>
> > I said I would make -rc kernels which would not add any new _feature_.
>
>That's less important.

I agree with releasing an extra -rc and waiting the extra day for -final.

My thought is that the _only_ difference between the last -rc and -final is 
correctly setting "EXTRAVERSION=" in Makefile.

David

