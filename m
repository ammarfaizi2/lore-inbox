Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbSJQEa5>; Thu, 17 Oct 2002 00:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbSJQEa5>; Thu, 17 Oct 2002 00:30:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10626 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261779AbSJQEaz>;
	Thu, 17 Oct 2002 00:30:55 -0400
Date: Wed, 16 Oct 2002 21:36:32 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: <kaza@kk.iij4u.or.jp>
cc: Hirokazu Takahashi <taka@valinux.co.jp>, <neilb@cse.unsw.edu.au>,
       <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
In-Reply-To: <20021016170213.GR19806%kaza@kk.iij4u.or.jp>
Message-ID: <Pine.LNX.4.33.0210162135380.29590-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 kaza@kk.iij4u.or.jp wrote:

| Hello,
|
| On Wed, Oct 16, 2002 at 08:09:00PM +0900,
| Hirokazu Takahashi-san wrote:
| > > After thinking about this some more, I suspect it would have to be
| > > quite large scale SMP to get much contention.
| >
| > I have no idea how much contention will happen. I haven't checked the
| > performance of it on large scale SMP yet as I don't have such a great
| > machines.
| >
| > Does anyone help us?
|
| Why don't you propose the performance test to OSDL? (OSDL-J is more
| better, I think)   OSDL provide hardware resources and operation staffs.

and why do you say that?  8;)

| If you want, I can help you to propose it. :-)

That's the right thing to do.

-- 
~Randy

