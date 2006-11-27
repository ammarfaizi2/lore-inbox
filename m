Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758518AbWK0S1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758518AbWK0S1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758527AbWK0S1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:27:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:41183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1758518AbWK0S1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:27:40 -0500
X-Authenticated: #14349625
Subject: Re: [patch] Re: 2.6.19-rc6-mm1 --
	sched-improve-migration-accuracy.patch slows boot
From: Mike Galbraith <efault@gmx.de>
To: Don Mullis <dwm@meer.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1164647852.2894.79.camel@localhost.localdomain>
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <1164484124.2894.50.camel@localhost.localdomain>
	 <1164522263.5808.12.camel@Homer.simpson.net>
	 <1164591509.2894.76.camel@localhost.localdomain>
	 <1164624611.5892.27.camel@Homer.simpson.net>
	 <1164647852.2894.79.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 19:27:06 +0100
Message-Id: <1164652026.6105.1.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 09:17 -0800, Don Mullis wrote:
> > The below should fix it, can you confirm?
> 
> Brings boot speed back to normal.
> 
> Acked-by: Don Mullis <dwm@meer.net>

Great.  Off to the brown paper bag store.

	-Mike

