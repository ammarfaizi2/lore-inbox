Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUIJGiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUIJGiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUIJGiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:38:04 -0400
Received: from [66.35.79.110] ([66.35.79.110]:62954 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S268327AbUIJGh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:37:59 -0400
Date: Thu, 9 Sep 2004 23:37:38 -0700
From: Tim Hockin <thockin@hockin.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-ID: <20040910063738.GA15319@hockin.org>
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org> <41413F64.40504@bigpond.net.au> <20040909231858.770ab381.akpm@osdl.org> <414149A0.1050006@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414149A0.1050006@bigpond.net.au>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 04:28:48PM +1000, Peter Williams wrote:
> All the way through and it's still occurring.  After the second patch 
> the symptoms changed slightly and it was a different gdm program that 
> triggered the oops.  But with all patches applied it's back to the 
> original symptoms.

What is special about the gdm programs wrt groups?
