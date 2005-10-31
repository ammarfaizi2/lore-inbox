Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVJaV2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVJaV2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVJaV2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:28:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:24731 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932526AbVJaV23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:28:29 -0500
Date: Mon, 31 Oct 2005 13:28:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051031132820.62a18822.pj@sgi.com>
In-Reply-To: <1130793655.4853.41.camel@akash.sc.intel.com>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051029184728.100e3058.pj@sgi.com>
	<1130793655.4853.41.camel@akash.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit wrote:
> Not sure why?  Let me see if some new values could better articulate the
> meaning. 

See also Nick's comments, before going too far.  He was advocating
just using binary flags and adding a gfp_high flag, or something
like that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
