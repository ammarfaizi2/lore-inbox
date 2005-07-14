Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbVGNUGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbVGNUGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbVGNUEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:04:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:16780 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263100AbVGNUCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:02:13 -0400
Subject: Re: [RFC][PATCH] split PCI probing code [1/9]
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050714193049.GA31595@kroah.com>
References: <1121331304.3398.89.camel@localhost.localdomain>
	 <20050714171014.GA16069@electric-eye.fr.zoreil.com>
	 <20050714193049.GA31595@kroah.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 15:54:25 -0400
Message-Id: <1121370865.3398.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 12:30 -0700, Greg KH wrote:
> On Thu, Jul 14, 2005 at 07:10:14PM +0200, Francois Romieu wrote:
> > Adam Belay <abelay@novell.com> :
> > [...]
> > 
> > Some nits + a suspect error branch. It seems nice otherwise.
> 
> If I'm correct, this patch only moves the code into different files, it
> doesn't change any of it, so your comments apply to the current code
> today, not Adam's changes :)

Correct.  I've been trying to make my changes incremental.  Nonetheless,
I do appreciate the comments.  I'll try to apply these fixes to my
current tree.

Thanks,
Adam


