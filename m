Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318896AbSICUNT>; Tue, 3 Sep 2002 16:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318898AbSICUNT>; Tue, 3 Sep 2002 16:13:19 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:39062 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318896AbSICUNQ>;
	Tue, 3 Sep 2002 16:13:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: Large block device patch, part 1 of 9
Date: Tue, 3 Sep 2002 22:19:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Benjamin LaHaise <bcrl@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Pavel Machek <pavel@suse.cz>, Peter Chubb <peter@chubb.wattle.id.au>,
       <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209031404500.3373-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209031404500.3373-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mK9X-0005kZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 22:05, Thunder from the hill wrote:
> Hi,
> 
> On Tue, 3 Sep 2002, Daniel Phillips wrote:
> > If you must have a clever macro:
> > 
> >    #define lli(foo) (long long int) (foo)
> >    #define llu(foo) (long long unsigned) (foo)
> 
> Type safety not given.

It's a printk for crying out loud.

-- 
Daniel
