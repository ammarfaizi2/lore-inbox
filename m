Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUKSMgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUKSMgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUKSMgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:36:40 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:52618 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261364AbUKSMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:36:35 -0500
Date: Fri, 19 Nov 2004 23:36:14 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac10
Message-ID: <20041119123613.GA1309@zip.com.au>
References: <1100789415.6005.1.camel@localhost.localdomain> <20041119030741.GC1231@zip.com.au> <1100863548.8127.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100863548.8127.3.camel@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:25:51AM +0000, Alan Cox wrote:
> On Gwe, 2004-11-19 at 03:07, CaT wrote:
> > On Thu, Nov 18, 2004 at 02:50:16PM +0000, Alan Cox wrote:
> > > The it8212 still doesn't default to DMA on - that is on the TODO list. The
> > 
> > Are you sure?
> 
> It will in pass through or with no RAID volume present but not with a
> hardware raid volume

Ahh. Ok. That's my situation. Carry on. Nothing to see here. :)

BTW. Thanks for the port. I can finally backup a windows machine as
rsync+cygwin froze consistantly and 2.4+cifs patch was slow to the point
of uselessness. 2.6.10-ac10 with rsync over cifs gives me a faster speed
then rsync+cygwin ever did, even with a tailwind.

-- 
    Red herrings strewn hither and yon.
