Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVBRFQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVBRFQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 00:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBRFQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 00:16:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:28097 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261208AbVBRFQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 00:16:47 -0500
Date: Thu, 17 Feb 2005 21:16:33 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: [RFC][PATCH] Sparse Memory Handling (hot-add foundation)
Message-ID: <20050218051633.GA5037@w-mikek2.ibm.com>
References: <1108685033.6482.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108685033.6482.38.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 04:03:53PM -0800, Dave Hansen wrote:
> The attached patch

Just tried to compile this and noticed that there is no definition
of valid_section_nr(),  referenced in sparse_init.

-- 
Mike
