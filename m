Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276653AbRJGUNp>; Sun, 7 Oct 2001 16:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276659AbRJGUNf>; Sun, 7 Oct 2001 16:13:35 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:30985 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276653AbRJGUNV>; Sun, 7 Oct 2001 16:13:21 -0400
Subject: Fwd: Re: SMP and preemption patch
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 07 Oct 2001 16:14:12 -0400
Message-Id: <1002485654.863.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Great patch...  I tried it on two SMP boxes I have.  I managed to create a
> load of 10, by generating a lot of disk IO, and a high priority process (alot
> doing disk IO), barely suffered at all.  Very nice.
>
> However, I did have two crashes.
>
> [...]

If anyone else is having problems with preemption on SMP, George
Anzinger of MontaVista has a solution in the newest preemptible kernel
patch that may solve it.

I am interested if anyone (a) has crashes with SMP and preemption and
(b) if this solves it.

Updated patches for 2.4.10, 2.4.11-pre4, and 2.4.10-ac7 are at
http://tech9.net/rml/linux

	Robert Love

