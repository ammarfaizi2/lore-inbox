Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTATOO5>; Mon, 20 Jan 2003 09:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbTATOO5>; Mon, 20 Jan 2003 09:14:57 -0500
Received: from cibs9.sns.it ([192.167.206.29]:27398 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S265863AbTATOO4>;
	Mon, 20 Jan 2003 09:14:56 -0500
Date: Mon, 20 Jan 2003 15:23:54 +0100 (CET)
From: venom@sns.it
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with kernel 2.5.59
In-Reply-To: <20030120164344.A2377@namesys.com>
Message-ID: <Pine.LNX.4.43.0301201523180.1706-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it was.

Before I started 2.5.59 I was running 2.4.20 with no problems at all.



On Mon, 20 Jan 2003, Oleg Drokin wrote:

> Date: Mon, 20 Jan 2003 16:43:44 +0300
> From: Oleg Drokin <green@namesys.com>
> To: venom@sns.it
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: ReiserFS corruption with kernel 2.5.59
>
> Hello!
>
> On Mon, Jan 20, 2003 at 02:23:58PM +0100, venom@sns.it wrote:
> > I was using reiserFS for the root FS on a desktop, just to test kernel 2.5.59,
> > and I started to get those messages:
> > PAP-14030: direct2indirect: pasted or inserted byte exists in the tree [5094
> > 5096 0x1001 IND]. Use fsck to repair.
> > Of course I repaired the FS.
>
> Was the FS clean before you started to use 2.5.59?
>
> Bye,
>     Oleg
>

