Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266265AbUARILc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 03:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbUARILb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 03:11:31 -0500
Received: from smtp06.auna.com ([62.81.186.16]:61650 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S266265AbUARILa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 03:11:30 -0500
Date: Sun, 18 Jan 2004 09:11:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.1-mm4
Message-ID: <20040118081128.GA3153@werewolf.able.es>
References: <20040115225948.6b994a48.akpm@osdl.org> <20040118001217.GE3125@werewolf.able.es> <20040117215535.0e4674b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040117215535.0e4674b8.akpm@osdl.org> (from akpm@osdl.org on Sun, Jan 18, 2004 at 06:55:35 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.18, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On 01.16, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/
> >  > 
> >  > 
> > 
> >  Net driver problem:
> > 
> >  werewolf:/etc# modprobe --verbose 3c59x
> >  insmod /lib/modules/2.6.1-jam4/kernel/drivers/net/3c59x.ko 
> >  FATAL: Error inserting 3c59x (/lib/modules/2.6.1-jam4/kernel/drivers/net/3c59x.ko): Invalid argument
> 
> hmm, cute.
> 

Yes.
It worked. 
I thought of this, but why this and not the other parameters ? Compiler bug ?

Witches...

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-jam4 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
