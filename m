Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286084AbRLTFHs>; Thu, 20 Dec 2001 00:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286085AbRLTFHi>; Thu, 20 Dec 2001 00:07:38 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:45066 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S286084AbRLTFH0>; Thu, 20 Dec 2001 00:07:26 -0500
Date: Thu, 20 Dec 2001 00:07:21 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200112200507.fBK57LC25752@devserv.devel.redhat.com>
To: cs@zip.com.au, "David S. Miller" <davem@redhat.com>
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <mailman.1008816001.10138.linux-kernel2news@redhat.com>
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com> <20011219171631.A544@burn.ucsd.edu> <20011219.172046.08320763.davem@redhat.com> <mailman.1008816001.10138.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> However, heavily threaded apps regardless of language are hardly likely
> to disappear; threads are the natural way to write many many things. And
> if the kernel implements threads as on Linux, then the scheduler will
> become much more important to good performance.

Cameron seems to be arguing with DaveM, but subconsciously he
only supports DaveM's point about AIO: Java cannot make use
of AIO, so that's one (large or small, important or unimportant)
group of applications down from the count.

Just trying to keep on topic :)

-- Pete
