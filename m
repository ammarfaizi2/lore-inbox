Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264758AbTFAXCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 19:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264761AbTFAXCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 19:02:09 -0400
Received: from smtp1.wanadoo.es ([62.37.236.135]:23525 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S264758AbTFAXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 19:02:09 -0400
Message-ID: <3EDA88F2.9060105@wanadoo.es>
Date: Mon, 02 Jun 2003 01:14:58 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: htree for 2.4 ext[23]
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> On Jun 01, 2003  15:17 +0400, Paul P Komkoff Jr wrote:
>> Anybody have working backport of these ?
>> 
>> Stuff available at http://thunk.org/tytso/linux/extfs-2.4-update/ IS a)
>> outdated b) gives unpredictable results (e.g. eating filesystems)
> 
> Yes, we have a working set of patches for 2.4.20 and a few other kernels
> in our CVS repository.  However, these are just taken from Ted's ext3 BK
> repository (I don't think we changed them at all).
> 
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-1.patch?rev=1.1.6.1&only_with_tag=b_devel
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-2.patch?rev=1.1.6.1&only_with_tag=b_devel
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-3.patch?rev=1.1.6.1&only_with_tag=b_devel
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-4.patch?rev=1.1.6.1&only_with_tag=b_devel

what is about mingo patches?
http://people.redhat.com/sct/patches/ext3-2.4/dev-20030314/
are same than tytso?

regards,
-- 
Software is like sex, it's better when it's bug free.

