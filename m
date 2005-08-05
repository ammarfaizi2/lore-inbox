Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVHEHkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVHEHkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVHEHkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:40:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261403AbVHEHkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:40:21 -0400
Date: Fri, 5 Aug 2005 00:38:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: zippel@linux-m68k.org, arjan@infradead.org, domen@coderock.org,
       linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] add schedule_timeout_{,un}intr() interfaces
Message-Id: <20050805003855.4621456e.akpm@osdl.org>
In-Reply-To: <20050804190023.GA4411@us.ibm.com>
References: <Pine.LNX.4.61.0507231911540.3743@scrub.home>
	<20050723191004.GB4345@us.ibm.com>
	<Pine.LNX.4.61.0507232151150.3743@scrub.home>
	<20050727222914.GB3291@us.ibm.com>
	<Pine.LNX.4.61.0507310046590.3728@scrub.home>
	<20050801193522.GA24909@us.ibm.com>
	<Pine.LNX.4.61.0508031419000.3728@scrub.home>
	<20050804005147.GC4255@us.ibm.com>
	<Pine.LNX.4.61.0508041123220.3728@scrub.home>
	<20050804100810.293c9ba6.akpm@osdl.org>
	<20050804190023.GA4411@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> wrote:
>
> Add schedule_timeout_{,un}intr() interfaces

I did s/intr/interruptible/.
