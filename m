Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWDVU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWDVU6z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWDVU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:58:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54998 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751191AbWDVU6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:58:55 -0400
Date: Fri, 21 Apr 2006 19:33:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: sekharan@us.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
Message-Id: <20060421193329.39fbfc24.akpm@osdl.org>
In-Reply-To: <1145672444.21109.701.camel@stark>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	<1145630992.3373.6.camel@localhost.localdomain>
	<1145638722.14804.0.camel@linuxchandra>
	<20060421155727.4212c41c.akpm@osdl.org>
	<1145670536.15389.132.camel@linuxchandra>
	<20060421191340.0b218c81.akpm@osdl.org>
	<1145672444.21109.701.camel@stark>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley <matthltc@us.ibm.com> wrote:
>
> > (btw, using the term "class" to identify a group of tasks isn't very
>  > comfortable - it's an instance, not a class...)
> 
>  Yes, I can see how this would be uncomfortable. How about replacing
>  "class" with "resource group"?

Much more comfortable, thanks ;)
