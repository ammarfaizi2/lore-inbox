Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCaXLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCaXLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVCaXLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:11:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:14731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261336AbVCaXLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:11:36 -0500
Date: Thu, 31 Mar 2005 15:11:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH 2.6.12-rc1-mm5 1/3] perfctr: ppc64 arch hooks
Message-Id: <20050331151129.279b0618.akpm@osdl.org>
In-Reply-To: <200503312207.j2VM7YUI011924@alkaid.it.uu.se>
References: <200503312207.j2VM7YUI011924@alkaid.it.uu.se>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Here's a 3-part patch kit which adds a ppc64 driver to perfctr,
> written by David Gibson <david@gibson.dropbear.id.au>.

Well that seems like progress.  Where do we feel that we stand wrt
preparedness for merging all this up?

