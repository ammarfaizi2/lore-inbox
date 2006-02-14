Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWBNBmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWBNBmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 20:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWBNBmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 20:42:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:6372 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750890AbWBNBmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 20:42:51 -0500
Date: Tue, 14 Feb 2006 07:15:22 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <balbir@in.ibm.com>
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
Message-ID: <20060214014522.GB28942@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060209061142.2164.35994.sendpatchset@debian> <20060209061147.2164.4528.sendpatchset@debian> <20060213143345.GA12279@in.ibm.com> <20060213235529.CB13674035@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213235529.CB13674035@sv1.valinux.co.jp>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 08:55:29AM +0900, KUROSAWA Takahiro wrote:
> Ah, you are right.  LHS is on per-cpu scale.
> I'll apply your patch.

Great! I also feel that "guarantee" can be explained better (in your first 
documentation patch), especially in the context of multi-cpu systems. Initially 
I was confused what guarantee means in SMP.

-- 
Regards,
vatsa
