Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWDWJbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWDWJbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 05:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDWJbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 05:31:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9902 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750816AbWDWJbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 05:31:42 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060422235201.4ab22b03.pj@sgi.com>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
	 <1145638722.14804.0.camel@linuxchandra>
	 <20060421155727.4212c41c.akpm@osdl.org>
	 <1145670536.15389.132.camel@linuxchandra>
	 <20060421191340.0b218c81.akpm@osdl.org>
	 <20060422235201.4ab22b03.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Sun, 23 Apr 2006 02:31:05 -0700
Message-Id: <1145784666.7099.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 23:52 -0700, Paul Jackson wrote:
> Andrew wrote:
> > (btw, using the term "class" to identify a group of tasks isn't very
> > comfortable - it's an instance, not a class...)
> 
> Bless you.  I objected to the term 'class' a long time ago, but failed
> to advance my case in a successful fashion.

	Well, I wouldn't say you were entirely unsuccessful. I distinctly
remembered your case and I tried to think of suitable names during the
recent changes. Please take a look at the latest set of patches and see
if you think the names are clearer.

> Matt replied:
> > "resource group"?
> 
> Nice.

Cheers,
	-Matt Helsley

