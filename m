Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbSJNKno>; Mon, 14 Oct 2002 06:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSJNKno>; Mon, 14 Oct 2002 06:43:44 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:58270 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S263571AbSJNKnn>;
	Mon, 14 Oct 2002 06:43:43 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210141045.OAA10901@sex.inr.ac.ru>
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
To: davem@redhat.com (David S. Miller)
Date: Mon, 14 Oct 2002 14:45:33 +0400 (MSD)
Cc: neilb@cse.unsw.edu.au, taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
In-Reply-To: <20021013.231534.08939486.davem@redhat.com> from "David S. Miller" at Oct 13, 2 11:15:34 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey is working on this, or at least he was. :-)
> (Alexey this is about the UDP cork changes)

I took two patches of the batch:

va10-hwchecksum-2.5.36.patch
va11-udpsendfile-2.5.36.patch

I did not worry about the rest i.e. sunrpc/* part.

Alexey
