Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbTGHMTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267261AbTGHMTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:19:18 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:33285 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267256AbTGHMTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:19:17 -0400
Date: Tue, 8 Jul 2003 13:33:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FAT statfs loop abort on read-error
Message-ID: <20030708133349.A24315@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>
References: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de> <20030706102410.2becd137.rddunlap@osdl.org> <87u19ypc1j.fsf@devron.myhome.or.jp> <20030707172431.A26138@infradead.org> <874r1xi53w.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <874r1xi53w.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Tue, Jul 08, 2003 at 09:18:43PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:18:43PM +0900, OGAWA Hirofumi wrote:
> Thank you very much. I try it.
> 
> Please apply the following patch.

You've forgot to add yourself for the generic fat and msdosfs bits :)

