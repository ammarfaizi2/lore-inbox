Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274972AbTHFXvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTHFXvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:51:18 -0400
Received: from zok.SGI.COM ([204.94.215.101]:44252 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S275044AbTHFXuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:50:06 -0400
Date: Thu, 7 Aug 2003 09:48:53 +1000
From: Nathan Scott <nathans@sgi.com>
To: Teemu Tervo <teemu.tervo@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/xfs/pagebuf/page_buf.c:1291!
Message-ID: <20030806234853.GB854@frodo>
References: <20030728202924.1b6a359b.teemu.tervo@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728202924.1b6a359b.teemu.tervo@gmx.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 08:29:24PM +0300, Teemu Tervo wrote:
> 
> Both -test1 and -test2 crash daily during high load. .config and
> kmsgdump output attached. It's been reported before by Andreas
> Heilwagen, see:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0306.3/0357.html
> 

FYI - this issue has been fixed in recent XFS CVS kernels, and
will be pushed to Linus at some point soon, along with several
other XFS fixes.

cheers.

-- 
Nathan
