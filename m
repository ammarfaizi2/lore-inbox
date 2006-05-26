Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWEZOJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEZOJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEZOJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:09:49 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:4483 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750763AbWEZOJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:09:48 -0400
Message-ID: <348652585.13489@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 22:09:51 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 02/33] radixtree: introduce __radix_tree_lookup_parent()
Message-ID: <20060526140951.GA13954@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060526113906.084341801@localhost.localdomain> <348644373.06563@ustc.edu.cn> <Pine.LNX.4.64.0605260656090.30694@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605260656090.30694@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 06:56:47AM -0700, Christoph Lameter wrote:
> On Fri, 26 May 2006, Wu Fengguang wrote:
> 
> > Introduce a general lookup function to radix tree.
> > 
> > - __radix_tree_lookup_parent(root, index, level)
> > 	Perform partial lookup, return the @level'th parent of the slot at
> > 	@index.
> > 
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Would you please remove my signoff? I never reviewed this code.

Sorry, ok.
