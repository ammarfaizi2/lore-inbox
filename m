Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbTCLMPl>; Wed, 12 Mar 2003 07:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263161AbTCLMPl>; Wed, 12 Mar 2003 07:15:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:1393 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263160AbTCLMPk>;
	Wed, 12 Mar 2003 07:15:40 -0500
Message-Id: <5.2.0.9.2.20030312132025.00c97520@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 12 Mar 2003 13:30:56 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <200303122219.49195.kernel@kolivas.org>
References: <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net>
 <5.2.0.9.2.20030312101646.00c8e238@pop.gmx.net>
 <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:19 PM 3/12/2003 +1100, Con Kolivas wrote:
>On Wed, 12 Mar 2003 21:37, Mike Galbraith wrote:
> > >Is this in addition to your previous errr hack or instead of?
> >
> > Instead of.  The buttugly patch destroyed interactivity.  This one cures
> > starvation, and interactivity is really nice.
>
>Ok that fixes the "getting stuck in process load" but it still hangs on
>contest. I'll just have to give mm5 a go and see if whatever problem that was
>went away in the mean time.

(%$&#!!)

Oh well, Ingo probably has it nailed already anyway.

         -Mike

(but meanwhile, where's your website again?) 

