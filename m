Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318189AbSGWRGX>; Tue, 23 Jul 2002 13:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSGWRFu>; Tue, 23 Jul 2002 13:05:50 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37541 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318177AbSGWREv>; Tue, 23 Jul 2002 13:04:51 -0400
Date: Tue, 23 Jul 2002 13:08:00 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207231708.g6NH80218466@devserv.devel.redhat.com>
To: dmarkh@cfl.rr.com
cc: linux-kernel@vger.kernel.org
Subject: Re: bigphysarea
In-Reply-To: <mailman.1027420021.27849.linux-kernel2news@redhat.com>
References: <mailman.1027420021.27849.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...] We have been using the bigphysarea patch and seems
> to do what we need for this card. We have been using it sice the beginning to the 2.4 
> series kernel. My question is, is this patch still nessessary or is there possibly a
> way do do this now without the patch?

I think Pauline never bothered to submit it. In Welsh's times
it was considered too esoteric for inclusion, but nowdays we
carry so much bloat that I'd think bigphysarea can be included.
If you want it included, take over the issue and bug Linus.

-- Pete
