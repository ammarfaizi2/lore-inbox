Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161358AbWI2IDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161358AbWI2IDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161496AbWI2IDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:03:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2241 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161358AbWI2IDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:03:43 -0400
Date: Fri, 29 Sep 2006 01:03:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: sekharan@us.ibm.com, jtk@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       viro@zeniv.linux.org.uk, lse-tech@lists.sourceforge.net,
       sgrubb@redhat.com, hch@lst.de
Subject: Re: [Lse-tech] [RFC][PATCH 05/10] Task watchers v2 Register cpuset
 task watcher
Message-Id: <20060929010315.dc6b84b6.pj@sgi.com>
In-Reply-To: <1159516338.3286.10.camel@localhost.localdomain>
References: <20060929020232.756637000@us.ibm.com>
	<20060929021300.851205000@us.ibm.com>
	<20060928193138.963c510a.pj@sgi.com>
	<1159516338.3286.10.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> If you look in the first patch there's a corresponding
> notify_task_watchers(WATCH_TASK_FREE, tsk) ...

Ok - thanks.  Looks like I was missing something.  Good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
