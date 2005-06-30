Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVF3Sme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVF3Sme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVF3Sme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:42:34 -0400
Received: from relay1.wplus.net ([195.131.52.143]:4162 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S262885AbVF3Sm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:42:29 -0400
From: Vitaly Fertman <vitaly@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
Date: Thu, 30 Jun 2005 22:30:04 +0400
User-Agent: KMail/1.7.1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org> <20050627193051.GA22208@infradead.org> <42C06390.5070609@namesys.com>
In-Reply-To: <42C06390.5070609@namesys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200506302230.05403.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2005 00:37, Hans Reiser wrote:
> Christoph Hellwig wrote:
> 
> >>reiser4
> >>    
> >>
> >
> >sparse isn't to happy about this:
> >
> >hch@macfly:/work/linux-2.6.12$ make C=1 SUBDIRS=fs/reiser4/ >/dev/null 2>err.log && wc -l err.log
> >2286 err.log
> >
> >The log is at http://verein.lst.de/~hch/linux-2.6.12-mm2-fs-reiser4-errors.log
> >
> >
> >  
> >
> Thanks for telling us about sparse, we will work on fixing these. 
> Vitaly, can you do this?

fixed, will be included into the next mm kernel.

-- 
Thanks,
Vitaly Fertman
