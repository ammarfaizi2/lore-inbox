Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWIFWGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWIFWGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWIFWGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:06:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:58074 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751745AbWIFWGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:06:17 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: balbir@in.ibm.com
Cc: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44FF1EE4.3060005@in.ibm.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>  <44FF1EE4.3060005@in.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 06 Sep 2006 15:06:11 -0700
Message-Id: <1157580371.31893.36.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 00:47 +0530, Balbir Singh wrote:

<snip>
> 
> Some not quite so urgent ones - like support for guarantees. I think this can

IMO, guarantee support should be considered to be part of the
infrastructure. Controller functionalities/implementation will be
different with/without guarantee support. In other words, adding
guarantee feature later will cause re-implementations.

> be worked out as we make progress.
> 
> > I agree with these requirements and lets move into this direction.
> > But moving so far can't be done without accepting:
> > 1. core functionality
> > 2. accounting
> > 
> 
> Some of the core functionality might be a limiting factor for the requirements.
> Lets agree on the requirements, I think its a great step forward and then
> build the core functionality with these requirements in mind.
> 
> > Thanks,
> > Kirill
> > 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


