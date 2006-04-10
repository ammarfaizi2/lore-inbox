Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWDJSzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWDJSzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWDJSzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:55:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48552 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932085AbWDJSzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:55:48 -0400
Subject: Re: [RFC/PATCH] Shared Page Tables [1/2]
From: Dave Hansen <haveblue@us.ibm.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <1144685591.570.36.camel@wildcat.int.mccr.org>
References: <1144685591.570.36.camel@wildcat.int.mccr.org>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 11:54:56 -0700
Message-Id: <1144695296.31255.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 11:13 -0500, Dave McCracken wrote:
> Complete the macro definitions for pxd_page/pxd_page_kernel 

Could you explain a bit why these are needed for shared page tables?

-- Dave

