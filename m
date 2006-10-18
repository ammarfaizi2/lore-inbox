Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWJRMou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWJRMou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWJRMou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:44:50 -0400
Received: from unthought.net ([212.97.129.88]:10501 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1160997AbWJRMot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:44:49 -0400
Date: Wed, 18 Oct 2006 14:44:50 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018124450.GX23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jens Axboe <jens.axboe@oracle.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Phetteplace, Thad (GE Healthcare, consultant)" <Thad.Phetteplace@ge.com>,
	linux-kernel@vger.kernel.org
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161175344.9363.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:42:24PM +0100, Alan Cox wrote:
> Ar Mer, 2006-10-18 am 14:23 +0200, ysgrifennodd Jakob Oestergaard:
> > iops/sec is what you get from your disks. In real world scenarios. It's
> > no more magic than the real world, and no harder to understand than real
> > world disks. Although I admit real-world disks can be a bitch at times ;)
> 
> Even iops/sec is very vague and arbitary. If your disk happens to be
> retrying a sector or doing a cleaning pass or any other housekeeping or
> vibration damping and so on you'll get very different numbers.

True.

> 
> Bandwidth is completely silly in this context, iops/sec is merely
> hopeless 8)

Thanks Alan - I feel much better now  :)

-- 

 / jakob

