Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVBPT4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVBPT4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVBPT4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:56:08 -0500
Received: from galileo.bork.org ([134.117.69.57]:40928 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261541AbVBPT4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:56:03 -0500
Date: Wed, 16 Feb 2005 14:56:03 -0500
From: Martin Hicks <mort@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050216195603.GC26705@localhost>
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214193704.00d47c9f.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Feb 14, 2005 at 07:37:04PM -0800, Paul Jackson wrote:
> Questions concerning this page cache patch that Martin submitted,
> as a merge of something originally written by Ray Bryant.
> 
> The following patch is not really a patch.  It is a few questions, a
> couple minor space tweaks, and a never compiled nor tested rewrite of
> proc_do_toss_page_cache_nodes() to try to make it look a little
> prettier.

Thanks for the review Paul.  I'll take a harder look at your feedback
and reply.

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
