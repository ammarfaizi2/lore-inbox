Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVHBOEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVHBOEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVHBOEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:04:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13449 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261536AbVHBODJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:03:09 -0400
Message-ID: <ED373A183611D311A6220060943F134C084821FE@eag-eaga002e--n.americas.sgi.com>
From: Dan Higgins <djh@SGI.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Robin Holt <holt@SGI.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [patch 2.6.13-rc4] fix get_user_pages bug
Date: Tue, 2 Aug 2005 09:02:43 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday, August 01, 2005, Linus Torvalds wrote:
> 
> Also, I haven't actually heard from whoever actually
> noticed the problem in the first place (Robin?) whether
> the fix does fix it. It "obviously does", but testing
> is always good ;)

Robin took yesterday & today (Tues) off but will test the fix asap tomorrow.

---
Dan Higgins - SGI
