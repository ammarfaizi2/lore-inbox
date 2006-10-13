Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWJMUQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWJMUQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWJMUQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:16:47 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:22216 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751872AbWJMUQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:16:46 -0400
Date: Fri, 13 Oct 2006 16:16:27 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi, ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
Message-ID: <20061013201627.GC31928@filer.fsl.cs.sunysb.edu>
References: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu> <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu> <20061013122706.56970df2.akpm@osdl.org> <20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 04:07:05PM -0400, Josef Sipek wrote:
... 
> These functions come from the FiST templates [1]. Some of these can
> definitely removed, or split up.

Forgot to say what [1] was...

[1] http://www.filesystems.org/

Josef "Jeff" Sipek.

-- 
It used to be said [...] that AIX looks like one space alien discovered
Unix, and described it to another different space alien who then implemented
AIX. But their universal translators were broken and they'd had to gesture a
lot.
		- Paul Tomblin 
