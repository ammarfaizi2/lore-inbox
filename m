Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbUKXReV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUKXReV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbUKXRYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:24:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15543 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262687AbUKXRD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:03:28 -0500
Date: Wed, 24 Nov 2004 08:19:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3
Message-ID: <20041124161923.GT2714@holomorphy.com>
References: <20041121223929.40e038b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 10:39:29PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/
> - It's time to shut things down for a 2.6.10 release now.  I'll do another
>   pass through the -mm lineup for things which should go into 2.6.10.  
>   If anyone has patches in -mm which they think should go into 2.6.10 please
>   let me know.  (particularly ppc/ppc64).  The v4l patches certainly look like
>   they need to go in.

Well, for the record, sparc32 isn't close to surviving the set of
changes here, where a small set of fixes got virgin 2.6.10-rc2 running.
The obvious compilefixes and porting the pending bugfixes did not
suffice.


-- wli
