Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271072AbRIGDu6>; Thu, 6 Sep 2001 23:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271082AbRIGDut>; Thu, 6 Sep 2001 23:50:49 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:14854 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S271072AbRIGDug>;
	Thu, 6 Sep 2001 23:50:36 -0400
Date: Thu, 6 Sep 2001 20:37:23 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Samium Gromoff <_deepfire@mail.ru>
cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE UDMA blacklist++
In-Reply-To: <200109070633.f876XWH01002@vegae.deep.net>
Message-ID: <Pine.LNX.4.31.0109062036160.26853-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That should be obvious, PIIX3 is a MultiWord DMA limited old southbridge
design.

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

On Fri, 7 Sep 2001, Samium Gromoff wrote:

>      Now after 20+ days of error-free disk operation,
>   it may be somewhat clean that 60GXP ibm drive doesnt like
>    UDMA on pIIX3 controllers.
>
> cheers, Sam
>
>

