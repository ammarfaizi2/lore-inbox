Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSFZVlh>; Wed, 26 Jun 2002 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSFZVlg>; Wed, 26 Jun 2002 17:41:36 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:39600 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316928AbSFZVlg>; Wed, 26 Jun 2002 17:41:36 -0400
Date: Wed, 26 Jun 2002 17:45:35 -0400
To: Bongani <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-ID: <20020626214535.GA2877@lnuxlab.ath.cx>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org> <20020626204721.GK22961@holomorphy.com> <1025125214.1911.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025125214.1911.40.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 11:00:08PM +0200, Bongani wrote:
> IIRC the preemptive patch is now part of -ac

I don't think that's correct.  I currently have to apply rml's
preempt-kernel-rml-2.4.19-pre9-ac3-a.patch on top of 2.4.19-pre10-ac2 in
order to get preempt support.

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
