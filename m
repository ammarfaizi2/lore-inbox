Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKYOTv>; Sat, 25 Nov 2000 09:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130338AbQKYOTk>; Sat, 25 Nov 2000 09:19:40 -0500
Received: from jalon.able.es ([212.97.163.2]:19656 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S129295AbQKYOTZ>;
        Sat, 25 Nov 2000 09:19:25 -0500
Date: Sat, 25 Nov 2000 14:49:04 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LKCD from SGI
Message-ID: <20001125144904.E2877@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001125141830.C2877@werewolf.able.es> <7235.975158637@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <7235.975158637@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Nov 25, 2000 at 14:23:57 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 Nov 2000 14:23:57 Keith Owens wrote:
> On Sat, 25 Nov 2000 14:18:30 +0100, 
> "J . A . Magallon" <jamagallon@able.es> wrote:
> >Could the default target install names int the std kernel be changed to 
> >System.map -> System.map-$(KERNELRELEASE)
> >vmlinuz    -> vmlinuz-$(KERNELRELEASE)
> >and then symlink to that ?
> 
> We could do a lot of things in the install targets.  But none of them
> are going to be done before kernel 2.5.  We are in code freeze (is this
> freeze number 4 or 5?).  Changing the install method just before a new
> kernel branch is released will not be popular with the distributors.

Yes, I know. I thought you were talking about '2.5 kernel build wish list'.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
