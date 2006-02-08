Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWBHVD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWBHVD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBHVD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:03:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64141 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932404AbWBHVD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:03:56 -0500
Date: Wed, 8 Feb 2006 13:03:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208130351.fc1c759c.pj@sgi.com>
In-Reply-To: <200602082201.12371.ak@suse.de>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0602081228260.4335@schroedinger.engr.sgi.com>
	<20060208125521.b9a2aa5e.pj@sgi.com>
	<200602082201.12371.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think you really want to open a  full scale "is the oom killer needed"
> thread. Check the archives - there have been some going on for months.
> 
> But I think we can agree that together with mbind the oom killer is pretty
> useless, can't we?

Excellent points.

I approve this patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
