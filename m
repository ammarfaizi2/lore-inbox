Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVIIBPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVIIBPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIIBP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:15:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47264 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965225AbVIIBP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:15:29 -0400
Date: Fri, 9 Sep 2005 11:15:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, nathans@sgi.com,
       xfs-masters@oss.sgi.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linus Git tree - xfs.o broken?
Message-ID: <20050909111524.B4691933@wobbly.melbourne.sgi.com>
References: <1126228321.5043.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1126228321.5043.5.camel@localhost.localdomain>; from abonilla@linuxwireless.org on Thu, Sep 08, 2005 at 07:12:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 07:12:01PM -0600, Alejandro Bonilla Beeche wrote:
> Hi,
> ld: fs/xfs/quota/: No such file: File format not recognized
> make[3]: *** [fs/xfs/xfs.o] Error 1
> make[2]: *** [fs/xfs] Error 2
> make[1]: *** [fs] Error 2
> make[1]: Leaving directory `/root/linux-2.6'
> make: *** [stamp-build] Error 2
> debian:~/linux-2.6# cd ..

Yes, fix is in progress.  Sorry about that.

cheers.

-- 
Nathan
