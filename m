Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTH0EmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 00:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTH0EmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 00:42:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42653 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263100AbTH0EmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 00:42:12 -0400
Subject: Re: Compile problem with CONFIG_X86_CYCLONE_TIMER Re:
	2.6.0-test4-mm1
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, John Stultz <johnstul@us.ibm.com>
In-Reply-To: <20030827010849.GA5280@matchmail.com>
References: <20030815203620.GO1027@matchmail.com>
	 <1061065941.31662.35.camel@nighthawk> <20030827010849.GA5280@matchmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061959279.12881.6.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Aug 2003 21:41:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 18:08, Mike Fedyk wrote:
> This patch to my .config makes it compile:

I tried 2.6.0-test4-mm1 with your config and didn't have any problems. 
Could you check with your old config to make sure I'm not missing
something?

-- 
Dave Hansen
haveblue@us.ibm.com

