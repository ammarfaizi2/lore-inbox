Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265229AbSJPQ6r>; Wed, 16 Oct 2002 12:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSJPQ6r>; Wed, 16 Oct 2002 12:58:47 -0400
Received: from r-kk.iij4u.or.jp ([210.130.0.73]:30687 "EHLO r-kk.iij4u.or.jp")
	by vger.kernel.org with ESMTP id <S265229AbSJPQ6p>;
	Wed, 16 Oct 2002 12:58:45 -0400
Date: Thu, 17 Oct 2002 02:02:15 +0900
From: kaza@kk.iij4u.or.jp
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: neilb@cse.unsw.edu.au, davem@redhat.com, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20021016170213.GR19806%kaza@kk.iij4u.or.jp>
References: <15786.23306.84580.323313@notabene.cse.unsw.edu.au> <20021014.210144.74732842.taka@valinux.co.jp> <15788.57476.858253.961941@notabene.cse.unsw.edu.au> <20021016.200900.128068491.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016.200900.128068491.taka@valinux.co.jp>
User-Agent: Mutt/1.3.27i-ja.2
X-Dispatcher: Nomail 0.4.9 (Caravanserai)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 16, 2002 at 08:09:00PM +0900,
Hirokazu Takahashi-san wrote:
> > After thinking about this some more, I suspect it would have to be
> > quite large scale SMP to get much contention.
> 
> I have no idea how much contention will happen. I haven't checked the
> performance of it on large scale SMP yet as I don't have such a great
> machines.
> 
> Does anyone help us?

Why don't you propose the performance test to OSDL? (OSDL-J is more
better, I think)   OSDL provide hardware resources and operation staffs.

If you want, I can help you to propose it. :-)

-- 
Ko Kazaana / editor-in-chief of "TechStyle" ( http://techstyle.jp/ )
GnuPG Fingerprint = 1A50 B204 46BD EE22 2E8C  903F F2EB CEA7 4BCF 808F
