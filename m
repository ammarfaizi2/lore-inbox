Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWHHDsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWHHDsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWHHDsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:48:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23943 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932332AbWHHDsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:48:45 -0400
Date: Mon, 7 Aug 2006 20:48:22 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gnb@melbourne.sgi.com, zwane@arm.linux.org.uk, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 2] cpumask: use EXPORT_SYMBOL_GPL for new exports
Message-Id: <20060807204822.91c4094d.pj@sgi.com>
In-Reply-To: <20060807203914.6aec29df.akpm@osdl.org>
References: <1155007534.29877.215.camel@hole.melbourne.sgi.com>
	<20060807203914.6aec29df.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All the existing exports in lib/cpumask.c are EXPORT_SYMBOL() so I'd be
> inclined to make any new exports match that.
> 
> OK?

ok here too

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
