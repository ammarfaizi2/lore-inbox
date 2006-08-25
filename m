Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWHYTB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWHYTB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHYTB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:01:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62393 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750985AbWHYTB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:01:57 -0400
Date: Fri, 25 Aug 2006 12:01:30 -0700
From: Paul Jackson <pj@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org,
       simon.derr@bull.net, nathanl@austin.ibm.com, akpm@osdl.org,
       y-goto@jp.fujitsu.com
Subject: Re: memory hotplug - looking for good place for cpuset hook
Message-Id: <20060825120130.9e3ab2d1.pj@sgi.com>
In-Reply-To: <20060826025749.6b3ae702.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060825015359.1c9eab45.pj@sgi.com>
	<20060825184717.3dbb5325.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825095718.9e22e777.pj@sgi.com>
	<20060826025749.6b3ae702.kamezawa.hiroyu@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kame wrote:
> Ah yes. I think yours is better logic.

Ok - good.  I'll let you worry about whether it
is worth putting in a patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
