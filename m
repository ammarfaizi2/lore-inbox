Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUJEANl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUJEANl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268722AbUJEANl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:13:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:52685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268714AbUJEAIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:08:32 -0400
Date: Mon, 4 Oct 2004 17:08:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2 ip_conntrack problems
Message-Id: <20041004170853.34d25529.akpm@osdl.org>
In-Reply-To: <200410041941.56453.edt@aei.ca>
References: <20041004020207.4f168876.akpm@osdl.org>
	<200410041941.56453.edt@aei.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <edt@aei.ca> wrote:
>
> Has anyone figured out how to fix this one (9-rc3-mm1 compiled ok).
> 
>   CC [M]  net/ipv4/netfilter/ip_conntrack_standalone.o
> net/ipv4/netfilter/ip_conntrack_standalone.c:34:47: linux/netfilter_ipv4/ip_conntrack.h: No such file or directory

Works for me.  Perhaps you're missing that file?
