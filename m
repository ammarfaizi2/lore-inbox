Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263134AbTCLKWb>; Wed, 12 Mar 2003 05:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263136AbTCLKWb>; Wed, 12 Mar 2003 05:22:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:57935 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263134AbTCLKWa>;
	Wed, 12 Mar 2003 05:22:30 -0500
Message-Id: <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 12 Mar 2003 11:37:38 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <200303122125.44731.kernel@kolivas.org>
References: <5.2.0.9.2.20030312101646.00c8e238@pop.gmx.net>
 <5.2.0.9.2.20030310105217.00cd25b0@pop.gmx.net>
 <5.2.0.9.2.20030310075720.00c832f8@pop.gmx.net>
 <5.2.0.9.2.20030312101646.00c8e238@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:25 PM 3/12/2003 +1100, Con Kolivas wrote:
>On Wed, 12 Mar 2003 20:21, Mike Galbraith wrote:
> > I can't help myself... the attached is just too simple and works too darn
> > well.
> >
> > Somebody stop me! :)
>
>Sssssssssssmokin are ya Mike?

;-)

>Is this in addition to your previous errr hack or instead of?

Instead of.  The buttugly patch destroyed interactivity.  This one cures 
starvation, and interactivity is really nice.

         -Mike 

