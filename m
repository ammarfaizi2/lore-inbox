Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTIMGK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 02:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTIMGK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 02:10:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35070 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262052AbTIMGK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 02:10:28 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] fix ifdown/ifup bug
Date: Fri, 12 Sep 2003 16:30:43 -0700
User-Agent: KMail/1.5.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <3F623696.1080703@pobox.com>
In-Reply-To: <3F623696.1080703@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121630.44588.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Marcelo,
>
> If you haven't gotten this patch from somebody else, please make
> sure this is applied.  It fixes a bug I introduced in -pre3 when
> moving some helpers from tg3 to netdevice.h.
>

FYI it does not seem to fix this issue for me.

Fedor
