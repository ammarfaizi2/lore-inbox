Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbULQCBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbULQCBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 21:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbULQCBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 21:01:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:60654 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262718AbULQCBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 21:01:11 -0500
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0412170150080.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412170133560.793@scrub.home>
	 <1103244171.13614.2525.camel@localhost>
	 <Pine.LNX.4.61.0412170150080.793@scrub.home>
Content-Type: text/plain
Message-Id: <1103248865.13614.2621.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Dec 2004 18:01:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 16:51, Roman Zippel wrote:
> Could you explain a bit more, what exactly the problem is?

Maybe I should also say that this doesn't fix any bugs.  It simply makes
the headers easier to work with.  I've been doing a lot of work in those
headers for the memory hotplug effort, and I think that this is a
worthwhile cleanup effort.  Plus, it will make my memory hotplug patches
look a little less crazy :)

-- Dave

