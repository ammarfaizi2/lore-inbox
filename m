Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVKHTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVKHTzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKHTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:55:04 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:53215 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964839AbVKHTzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:55:03 -0500
Date: Tue, 8 Nov 2005 11:54:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051108115450.0fd3c619.pj@sgi.com>
In-Reply-To: <1131473876.2400.9.camel@akash.sc.intel.com>
References: <20051107174349.A8018@unix-os.sc.intel.com>
	<20051107175358.62c484a3.akpm@osdl.org>
	<1131416195.20471.31.camel@akash.sc.intel.com>
	<43701FC6.5050104@yahoo.com.au>
	<20051107214420.6d0f6ec4.pj@sgi.com>
	<43703EFB.1010103@yahoo.com.au>
	<1131473876.2400.9.camel@akash.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit wrote:
> Paul, sorry for troubling you with those magic numbers again in the
> original patch...

That's no problem.  I enjoyed the opportunity to protest it again ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
