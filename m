Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbULQAjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbULQAjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbULQAjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:39:21 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14514 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262346AbULQAg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:36:58 -0500
Date: Fri, 17 Dec 2004 01:36:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm@kvack.org
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
In-Reply-To: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0412170133560.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Dec 2004, Dave Hansen wrote:

> I'm working on breaking out the struct page definition into its
> own file.  There seem to be a ton of header dependencies that
> crop up around struct page, and I'd like to start getting rid
> of thise.

Why do you want to move struct page into a separate file?

bye, Roman
