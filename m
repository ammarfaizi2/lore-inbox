Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbSJNKue>; Mon, 14 Oct 2002 06:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSJNKud>; Mon, 14 Oct 2002 06:50:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4504 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264616AbSJNKud>;
	Mon, 14 Oct 2002 06:50:33 -0400
Date: Mon, 14 Oct 2002 03:48:53 -0700 (PDT)
Message-Id: <20021014.034853.77257674.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: neilb@cse.unsw.edu.au, taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210141045.OAA10901@sex.inr.ac.ru>
References: <20021013.231534.08939486.davem@redhat.com>
	<200210141045.OAA10901@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Mon, 14 Oct 2002 14:45:33 +0400 (MSD)

   I took two patches of the batch:
   
   va10-hwchecksum-2.5.36.patch
   va11-udpsendfile-2.5.36.patch
   
   I did not worry about the rest i.e. sunrpc/* part.

Neil and the NFS folks can take care of those parts
once the generic UDP parts are in.

So, no worries.
