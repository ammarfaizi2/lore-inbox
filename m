Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319166AbSIKP4l>; Wed, 11 Sep 2002 11:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319168AbSIKP4k>; Wed, 11 Sep 2002 11:56:40 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17143
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319166AbSIKP4k>; Wed, 11 Sep 2002 11:56:40 -0400
Subject: Re: XFS?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andi Kleen <ak@suse.de>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020911110502.12605A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1020911110502.12605A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 17:03:49 +0100
Message-Id: <1031760229.2768.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 16:12, Bill Davidsen wrote:
> More to the point, a quick scan of LKML will show that there are fixes for
> ext3 and reisser on a regular basis, so one must assume that they don't
> always work as they should either. XFS is in a number of distributions,
> and is stable for users.

Thats never been the big concern. The problem has always been that XFS
was very invasive code so it might break stuff for people who dont
choose to use experimental xfs stuff. Thats slowly improving

