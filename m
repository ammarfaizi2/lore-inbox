Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTGGQKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbTGGQKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:10:04 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:6413 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265045AbTGGQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:10:02 -0400
Date: Mon, 7 Jul 2003 17:24:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Sancho Dauskardt <sda@bdit.de>,
       linux-kernel@vger.kernel.org
Subject: Re: FAT statfs loop abort on read-error
Message-ID: <20030707172431.A26138@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Sancho Dauskardt <sda@bdit.de>,
	linux-kernel@vger.kernel.org
References: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de> <20030706102410.2becd137.rddunlap@osdl.org> <87u19ypc1j.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87u19ypc1j.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Tue, Jul 08, 2003 at 12:54:48AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 12:54:48AM +0900, OGAWA Hirofumi wrote:
> > (I asked him to add a patch to MAINTAINTERS...)
> 
> Thank you. But honestly, I may not have skill enough.

Given that you have done a nice job ob fatfs in 2.5 and there's no one
coming near that many useful contributions in that timeframe I think
it would be a good idea to declare you maintainer.  According to
MAINTAINERS it currently doesn't have any formal maintainer anyway.

