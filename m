Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUELAX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUELAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUELAMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:12:35 -0400
Received: from fmr04.intel.com ([143.183.121.6]:57239 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263467AbUELAAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:00:51 -0400
Date: Tue, 11 May 2004 16:58:53 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ashok.raj@intel.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [6/7]
Message-ID: <20040511165853.A21249@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040511161653.49e836e5.pj@sgi.com> <20040511163801.2a657b07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511163801.2a657b07.akpm@osdl.org>; from akpm@osdl.org on Tue, May 11, 2004 at 04:38:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 04:38:01PM -0700, Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> >
> > On the off chance that
> > others find this way of phrasing it helpful, I post it here for the
> > record.
> 
> Thanks, I added that to the changelog.  If you think additional code
> commentary is needed, please send patches.
> 
> I guess I'm not doing anything useful with these patches.  Is it OK with
> everyone if I scoot them over to davidm?


I had sent a private mail to davidm for inclusion in ia64 tree, he mentioned 
that it would be preferable to cook akpm tree to make sure no build breaks, 
and then he would consider those for inclusion in his tree. especially -mm gets
more testing, but iam not sure how may would really try this hotplug :-)

anytime now seems appropriate...

until David pickup's these it would be great to leave the here for anyone 
interested in testing...

Cheers,
Ashok
