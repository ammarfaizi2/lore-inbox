Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269615AbUHZU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269615AbUHZU7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269642AbUHZU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:56:34 -0400
Received: from [194.85.238.98] ([194.85.238.98]:62617 "EHLO school.ioffe.ru")
	by vger.kernel.org with ESMTP id S269597AbUHZUtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:49:35 -0400
Date: Fri, 27 Aug 2004 00:49:29 +0400
To: Christophe Saout <christophe@saout.de>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826204929.GA15329@school.ioffe.ru>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com> <1093548414.5678.74.camel@krustophenia.net> <20040826203017.GA14361@school.ioffe.ru> <1093552692.13881.43.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1093552692.13881.43.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.6+20040722i
From: mitya@school.ioffe.ru (Dmitry Baryshkov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Thu, Aug 26, 2004 at 10:38:12PM +0200, Christophe Saout wrote:
> 
> No. You can change the format the reiser4 storage tree is stored in. As
> long as other filesystems don't use the same underlying storage tree
> this is not possible.
> 

Thank you for clarification. As I wrote, it's too good to be true.

-- 
With best wishes
Dmitry Baryshkov


