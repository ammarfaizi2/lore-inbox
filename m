Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVCEHy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVCEHy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 02:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVCEHy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 02:54:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263121AbVCEHxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 02:53:47 -0500
Date: Sat, 5 Mar 2005 02:53:43 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050305075343.GA20513@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	chrisw@osdl.org
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050304143614.203278fd.akpm@osdl.org> <20050305000604.GA3355@kroah.com> <Pine.LNX.4.58.0503041627340.11349@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503041627340.11349@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 04:28:02PM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Fri, 4 Mar 2005, Greg KH wrote:
 > 
 > > On Fri, Mar 04, 2005 at 02:36:14PM -0800, Andrew Morton wrote:
 > > > But we end up with a cset in the permanent kernel history which simply
 > > > should not have been there.
 > > 
 > > Is this really a big deal?
 > 
 > Once? No. If it ends up being "par for the course", it's bad.

The amount of stuff in the sucker tree shouldn't really amount
to /that/ many patches should it ? If it does, then 2.6.x is in
worse shape than we've all been admitting.

Would it be that much work to just send the 'meat' as gnu patches,
and leave the not-for-linus stuff alone ?

		Dave

