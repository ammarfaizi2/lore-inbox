Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269011AbTCAUEk>; Sat, 1 Mar 2003 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269015AbTCAUEk>; Sat, 1 Mar 2003 15:04:40 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:9705 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S269011AbTCAUEj>; Sat, 1 Mar 2003 15:04:39 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] USB speedtouch: don't race the tasklets
Date: Sat, 1 Mar 2003 21:14:49 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <mailman.1046424703.308.linux-kernel2news@redhat.com> <200302282055.h1SKt9f01603@devserv.devel.redhat.com>
In-Reply-To: <200302282055.h1SKt9f01603@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303012114.49460.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 February 2003 21:55, Pete Zaitcev wrote:
> >  speedtouch.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
>
> My news gateway ate all interesting headers, so I cannot tell
> if you cc-ed it properly. The common practice is to send
> patches to: greg@kroah.com and cc: linux-usb-devel@lists.sourceforge.net.
> Linus probably won't pick anything USB directly off l-k.

Hi Pete - that's what I did.  I cc-ed the lkml in the hope of having the
patches flamed (= learning for me) by some of the fire-breathers there.

All the best,

Duncan.
