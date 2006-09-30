Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWI3AE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWI3AE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWI3AE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:04:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25824 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422860AbWI3AE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:26 -0400
Date: Fri, 29 Sep 2006 17:04:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: sekharan@us.ibm.com, jtk@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       viro@zeniv.linux.org.uk, lse-tech@lists.sourceforge.net,
       sgrubb@redhat.com, hch@lst.de
Subject: Re: [Lse-tech] [RFC][PATCH 02/10] Task watchers v2 Benchmark
Message-Id: <20060929170409.67412d9f.pj@sgi.com>
In-Reply-To: <1159574473.3286.83.camel@localhost.localdomain>
References: <20060929020232.756637000@us.ibm.com>
	<20060929021300.034805000@us.ibm.com>
	<20060928193243.c6766a2a.pj@sgi.com>
	<1159558733.3286.64.camel@localhost.localdomain>
	<20060929131350.ef1bd156.pj@sgi.com>
	<1159574473.3286.83.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> I would have thought so too, but it also appears to consistently reduce
> time spent in the kernel.

Interesting.  Thanks for the continuing good work.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
