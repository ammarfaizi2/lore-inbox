Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263376AbVCEAnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbVCEAnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbVCEAj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:39:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:46020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263521AbVCEA0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:26:35 -0500
Date: Fri, 4 Mar 2005 16:28:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
In-Reply-To: <20050305000604.GA3355@kroah.com>
Message-ID: <Pine.LNX.4.58.0503041627340.11349@ppc970.osdl.org>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
 <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org>
 <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org>
 <20050304220518.GC1201@kroah.com> <20050304143614.203278fd.akpm@osdl.org>
 <20050305000604.GA3355@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Greg KH wrote:

> On Fri, Mar 04, 2005 at 02:36:14PM -0800, Andrew Morton wrote:
> > But we end up with a cset in the permanent kernel history which simply
> > should not have been there.
> 
> Is this really a big deal?

Once? No. If it ends up being "par for the course", it's bad.

		Linus
