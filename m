Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJMLxN>; Sun, 13 Oct 2002 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJMLxN>; Sun, 13 Oct 2002 07:53:13 -0400
Received: from cibs9.sns.it ([192.167.206.29]:35338 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261501AbSJMLxM>;
	Sun, 13 Oct 2002 07:53:12 -0400
Date: Sun, 13 Oct 2002 13:58:58 +0200 (CEST)
From: venom@sns.it
To: jw schultz <jw@pegasys.ws>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
In-Reply-To: <20021012111140.GA22536@pegasys.ws>
Message-ID: <Pine.LNX.4.43.0210131354020.9392-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, jw schultz wrote:

> Date: Sat, 12 Oct 2002 04:11:40 -0700
> From: jw schultz <jw@pegasys.ws>
> To: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Linux v2.5.42
>
>
> I'll add my $0.02US which (according to exchange rates) is
> worth more though almost worthless.
>
> Hate to say it but in this comparison LVM2 looses.  Primary
> reason: Backward compatibility.  People are going to need to
> be able to switch between kernels.
>
> So far everything indicates that LVM2 is not compatible with
> LVM.  That LVM2 and LVM(1) can coexist-exist is irrelevant if
> 2.5 hasn't got a working LVM(1).  And that would leave us
> with having to do backup+restore around the upgrade.

that is I think the real issue for people like me. One day I will have to
upgrade my servers to kernel 2.6, and all of them are on LVM1. I need to
be able to upgrade them. with EVMS I can do so, but after I will have
other problems because of operator, now used to LVM command line (that is
the same they are using on other Unices), will also have to learn another
command line. If I am not wrong, the LVM1 like command line is going to
disappear from EVMS, and that will be a problem for many users.
EVMS is powerfull but somehow too complex for many.
So my 2 eurocents are for EVMS with "also" a LVM1 like command line.

Luigi


