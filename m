Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWI2Cc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWI2Cc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWI2Cc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:32:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30130 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964915AbWI2Cc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:32:57 -0400
Date: Thu, 28 Sep 2006 19:32:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, sekharan@us.ibm.com, jtk@us.ibm.com,
       jes@sgi.com, linux-audit@redhat.com, viro@zeniv.linux.org.uk,
       lse-tech@lists.sourceforge.net, sgrubb@redhat.com, hch@lst.de
Subject: Re: [Lse-tech] [RFC][PATCH 02/10] Task watchers v2 Benchmark
Message-Id: <20060928193243.c6766a2a.pj@sgi.com>
In-Reply-To: <20060929021300.034805000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
	<20060929021300.034805000@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> It is intended to be a tool for measuring the impact of task watchers
> on fork and exit-heavy workloads.

So ... you're keeping us in suspense ... what was the measured impact
of task watcher?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
