Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWFACwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWFACwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWFACwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:52:07 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:6803 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965192AbWFACwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:52:05 -0400
To: adilger@clusterfs.com
Cc: jitendra@linsyssoft.com, tytso@mit.edu, sct@redhat.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com
Subject: RE:[UPDATE][12/24]ext3 enlarge blocksize
Message-Id: <20060601115154sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 1 Jun 2006 11:51:54 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On May 31, 2006, Andreas wrote:
> On May 30, 2006  21:24 +0900, sho@tnes.nec.co.jp wrote:
> > On May 26, 2006, Andreas wrote:
> > > At least part of this patch can be included into the patch series
> > > that Mingming has posted to allow larger block sizes on 
> > > architectures that support it.  This doesn't need a separate
> > > COMPAT flag itself, since older kernels will already refuse to
> > > ount a filesystem with large blocks.
> > 
> > Do you mention block size?
> 
> Yes, it just seemed confusing to be including these two items in the
> same patch.  I was trying to indicate that the 64k block 
> support should
> be submitted to Mingming as a standalone patch atop her patch series,
> which is the one that will be submitted for kernel inclusion.

Hmm... I see what you're trying to say, but I'm working on typedef and
I'll post my patches later.


Cheers, sho


