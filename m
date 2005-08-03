Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVHCMSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVHCMSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVHCMPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:15:47 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:28843 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262269AbVHCMP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:15:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Wed, 3 Aug 2005 22:14:44 +1000
User-Agent: KMail/1.8.2
Cc: Jan De Luyck <lkml@kcore.org>, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <200508031354.52972.lkml@kcore.org>
In-Reply-To: <200508031354.52972.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508032214.45451.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005 21:54, Jan De Luyck wrote:
> On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> > Patch for 2.6.13-rc5
>
> Compiles and runs ok here.
>
> Is there actually any timer frequency that's advisable to set as maximum?
> (in the kernel config)

I'd recommend 1000.

Cheers,
Con
