Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266698AbUGLDEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266698AbUGLDEd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGLDEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:04:32 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:63943 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266695AbUGLDEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:04:22 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Voluntary Preempt + Ck5 Problems
Date: Sun, 11 Jul 2004 23:04:20 -0400
User-Agent: KMail/1.6.2
Cc: mingo@elte.hu, ck@vds.kolivas.org, linux-kernel@vger.kernel.org
References: <200407112254.52032.devenyga@mcmaster.ca> <cone.1089601296.571158.28499.502@pc.kolivas.org>
In-Reply-To: <cone.1089601296.571158.28499.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407112304.20996.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay then my mistake.

On Sunday 11 July 2004 23:01, Con Kolivas wrote:
> Gabriel Devenyi writes:
> > Hi Guys,
> >
> > Doing a non-scientific test of ck5 against 2.6.8-rc1 with ck5 and
> > voluntary preempt, it takes ~20 seconds to open konsole or kontact while
> > running "make -j30 all" on a linux-2.6.7 sourcetree. What kind of numbers
> > do you need to diagnose this issue. Please find my config attached.
>
> What's the issue here? If your load is 30 it should take 30 times longer to
> happen. The fact it takes less than 30 times longer already is a good thing
> for you. There is no point trying to optimise for less than that.
>
> Con

-- 
Gabriel Devenyi
devenyga@mcmaster.ca
