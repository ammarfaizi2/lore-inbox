Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWHVUAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWHVUAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWHVUAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:00:41 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:12791 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751169AbWHVUAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:00:40 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: James Morris <jmorris@namei.org>
Cc: David Miller <davem@davemloft.net>, johnpol@2ka.mipt.ru,
       linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <Pine.LNX.4.64.0608221059030.26026@d.namei>
References: <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
	 <20060822.012341.57449506.davem@davemloft.net>
	 <1156237191.8055.59.camel@entropy>
	 <Pine.LNX.4.64.0608221059030.26026@d.namei>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 13:00:23 -0700
Message-Id: <1156276823.2476.22.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 10:59 -0400, James Morris wrote:
> On Tue, 22 Aug 2006, Nicholas Miell wrote:
> 
> > In this brave new world of always stable kernel development, the time a
> > new interface has for public testing before a new kernel release is
> > drastically shorter than the old unstable development series, and if
> > nobody is documenting how this stuff is supposed to work and
> > demonstrating how it will be used, then mistakes are bound to slip
> > through.
> 
> Feel free to provide the documentation.  Perhaps, even as much as you've 
> written so far in these emails would be enough.
> 

I'm not the one proposing the new (potentially wrong) interface. The
onus isn't on me.

-- 
Nicholas Miell <nmiell@comcast.net>

