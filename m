Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSIJBxW>; Mon, 9 Sep 2002 21:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSIJBxW>; Mon, 9 Sep 2002 21:53:22 -0400
Received: from fmr06.intel.com ([134.134.136.7]:65250 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S317498AbSIJBxV>; Mon, 9 Sep 2002 21:53:21 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C446047588D5@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Hirokazu Takahashi'" <taka@valinux.co.jp>, davem@redhat.com
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] zerocopy NFS for 2.5.33
Date: Mon, 9 Sep 2002 18:58:00 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I know e1000 has a feature that it can split a 
> jumbo UDP frame into some IP fragments.

UDP segmentation but not UDP fragmentation, sorry.

-scott
