Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132273AbRCWARL>; Thu, 22 Mar 2001 19:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRCWANm>; Thu, 22 Mar 2001 19:13:42 -0500
Received: from feeder.cyberbills.com ([64.41.210.81]:44040 "EHLO
	sjc-smtp1.cyberbills.com") by vger.kernel.org with ESMTP
	id <S132276AbRCWAMg>; Thu, 22 Mar 2001 19:12:36 -0500
Date: Thu, 22 Mar 2001 16:11:48 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21
In-Reply-To: <E14gEd7-0003Yk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31ksi3.0103221611340.22847-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Alan Cox wrote:

OK.

> > On Thu, 22 Mar 2001, Alan Cox wrote:
> >
> > Does not build for PPro/P-II. i586 is OK.
>
> You need to avoid enabling 64G support. The PAE stuff (as Linus said
> with
> 2.4.3pre6) is currently broken. Once Linus and co fix it I'll merge the
> fixed
> one

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

