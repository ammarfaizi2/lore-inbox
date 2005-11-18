Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVKRWWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVKRWWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVKRWWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:22:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47334 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751046AbVKRWWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:22:35 -0500
Date: Fri, 18 Nov 2005 14:22:31 -0800
From: Paul Jackson <pj@sgi.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: MPP aware CPUSETS
Message-Id: <20051118142231.6ddbb1ca.pj@sgi.com>
In-Reply-To: <200511162337.23722.a1426z@gawab.com>
References: <200511162337.23722.a1426z@gawab.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would extending CPUSETS to make it MPP aware be a reasonable feature?

I might expect not to extend cpusets, so much as layer abstractions
on top of cpusets.

Though since my focus is not on multi-node systems, I don't have any
suggestions as to what sort of features and needs would drive such
work.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
