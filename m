Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWJJTkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWJJTkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWJJTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:40:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62126 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030229AbWJJTj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:39:57 -0400
Date: Tue, 10 Oct 2006 12:39:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@sunset.davemloft.net, linux-kernel@vger.kernel.org,
       vonbrand@inf.utfsm.cl
Subject: Re: Sparc64 stopped building - sigset_t unrecognized in compat.h
Message-Id: <20061010123951.41bb5283.pj@sgi.com>
In-Reply-To: <20061010123744.403dbea7.akpm@osdl.org>
References: <20061010115940.4c25ae83.pj@sgi.com>
	<20061010123744.403dbea7.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.19-rc1-mm1 builds OK on sparc64.

Good - I won't worry about 2.6.18-mm3 anymore.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
