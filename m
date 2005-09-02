Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbVIBASY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbVIBASY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 20:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbVIBASY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 20:18:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030593AbVIBASX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 20:18:23 -0400
Date: Thu, 1 Sep 2005 17:17:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 0/10] m68k/thread_info merge
Message-Id: <20050901171738.49d8893d.akpm@osdl.org>
In-Reply-To: <20050901171621.33d41b3c.akpm@osdl.org>
References: <Pine.LNX.4.61.0509012211010.8099@scrub.home>
	<20050901171621.33d41b3c.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Can I assume that the five m68k patches can be split apart from the five
> patches which dink with task_struct?  ie: if the task_struct patches go in
> later, does anything bad happen?

eh, forget I asked that.  They're interdependent.
