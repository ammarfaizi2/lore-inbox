Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVCUWB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVCUWB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVCUWB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:01:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:30907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261901AbVCUWBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:01:53 -0500
Date: Mon, 21 Mar 2005 14:01:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: torvalds@osdl.org, paulus@samba.org, anton@samba.org,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: ppc64 pSeries build broken in 2.6.12-rc1-bk1
Message-Id: <20050321140151.4ebc3f7d.akpm@osdl.org>
In-Reply-To: <20050321214537.GC16469@otto>
References: <20050321214537.GC16469@otto>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <ntl@pobox.com> wrote:
>
> It seems that the "pSeries reconfig" patch series which Paul sent on
> March 17th to Andrew on my behalf was incompletely merged into bk?

Yes, I was getting a different build error which those three patches
happened to fix, so I sent them in for 2.6.12-rc1.
