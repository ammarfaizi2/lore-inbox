Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUJTHb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUJTHb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270149AbUJTH1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:27:52 -0400
Received: from [192.55.52.67] ([192.55.52.67]:60519 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S270155AbUJTHWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:22:42 -0400
Subject: Re: Versioning of tree
From: Len Brown <len.brown@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1098254970.3223.6.camel@gaston>
References: <1098254970.3223.6.camel@gaston>
Content-Type: text/plain
Organization: 
Message-Id: <1098256951.26595.4296.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 03:22:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 02:49, Benjamin Herrenschmidt wrote:
> Hi Linus !
> 
> After you tag a "release" tree in bk, could you bump the version
> number right away, with eventually some junk in EXTRAVERSION like
> "-devel" ?

I'd find this to be really helpful too.  There has been this period
between, say, 2.6.9 and 2.6.10-whatever where my build/install scripts
scribble over my "reference" kernels.

thanks,
-Len

