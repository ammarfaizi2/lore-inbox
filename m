Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbRGLAur>; Wed, 11 Jul 2001 20:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbRGLAuh>; Wed, 11 Jul 2001 20:50:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23812 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267389AbRGLAuX>; Wed, 11 Jul 2001 20:50:23 -0400
Message-ID: <3B4CF429.D0B3B473@transmeta.com>
Date: Wed, 11 Jul 2001 17:49:45 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rajeev Bector <rajeev_bector@yahoo.com>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: new IPC mechanism ideas
In-Reply-To: <20010712001058.9730.qmail@web14402.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:
> 
> Thanks for your comment, Peter.
> The problem with using a "driver"
> process is that now you need
> another mechanism to communicate
> with that driver - either
> message queues or shared
> memory or something.
> 

You need that anyway.

	-hpa
