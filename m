Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVDAOlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVDAOlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVDAOlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:41:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51641 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261663AbVDAOlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:41:06 -0500
Date: Fri, 1 Apr 2005 06:39:19 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-Id: <20050401063919.742c9016.pj@engr.sgi.com>
In-Reply-To: <20050401103452.GA31082@elte.hu>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
	<424C8956.7070108@yahoo.com.au>
	<20050331220526.3719ed7f.pj@engr.sgi.com>
	<20050401065955.GB26203@elte.hu>
	<20050401012902.2fb1a992.pj@engr.sgi.com>
	<20050401103452.GA31082@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> but i'd too go for the simpler 'pseudo-distance' function, because it's 
> so much easier to iterate through it. But it's not intuitive. Maybe it 
> should be called 'connection ID': a unique ID for each uniqe type of 
> path between CPUs.

Well said.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
