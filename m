Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVCUBRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVCUBRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 20:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVCUBRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 20:17:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:5005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbVCUBRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 20:17:52 -0500
Date: Sun, 20 Mar 2005 17:17:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
Message-Id: <20050320171725.1b13ab87.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503201653310.2250@server.graphe.net>
References: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
	<20050320153446.32a9215a.akpm@osdl.org>
	<Pine.LNX.4.58.0503201653310.2250@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> On Sun, 20 Mar 2005, Andrew Morton wrote:
> 
> > > Hope Andrew is going to take the patch this time.
> >
> > Hope Kenneth is going to test the alternate del_timer_sync patches in next
> > -mm ;)
> 
> BTW Why are we going through this? Oleg has posted a much better solution
> to this issue yersteday AFAIK.

That is what I was referring to.

Those patches need to be reviewed, performance tested and stability tested.
It's appropriate that interested parties do that work, please.

