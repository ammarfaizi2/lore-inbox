Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTGKTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbTGKTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:19:30 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:9946
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265549AbTGKTSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:18:33 -0400
Date: Fri, 11 Jul 2003 15:33:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711193316.GA28806@gtf.org>
References: <20030711140219.GB16433@suse.de> <20030711181453.GA976@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711181453.GA976@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 11:14:53AM -0700, Mike Fedyk wrote:
> On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:
> > Enormous block size support.
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> How about "block device size" instead?  This made me think of blocks larger
> than page size initially (even though I know that hasn't happened).

Agreed.


> >   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> >      either use 2.4 or fix it 8)
> 
> Is this still true?  I seem to recall testing a kernel in the 2.5.6x range,
> and it worked.  (haven't tested more recent kernels yet -- compiling one now
> though)

IIRC Alan's comment was "this fixes 99% of it"

	Jeff



