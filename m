Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319018AbSIJDQQ>; Mon, 9 Sep 2002 23:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319019AbSIJDQQ>; Mon, 9 Sep 2002 23:16:16 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:47634 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319018AbSIJDQP>;
	Mon, 9 Sep 2002 23:16:15 -0400
Date: Tue, 10 Sep 2002 12:13:36 +0900 (JST)
Message-Id: <20020910.121336.95055718.taka@valinux.co.jp>
To: scott.feldman@intel.com
Cc: davem@redhat.com, nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS for 2.5.33
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <288F9BF66CD9D5118DF400508B68C446047588D5@orsmsx113.jf.intel.com>
References: <288F9BF66CD9D5118DF400508B68C446047588D5@orsmsx113.jf.intel.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > As far as I know e1000 has a feature that it can split a 
> > jumbo UDP frame into some IP fragments.
> 
> UDP segmentation but not UDP fragmentation, sorry.

Really?
it's too sad.
