Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVLGJzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVLGJzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVLGJzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:55:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbVLGJzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:55:09 -0500
Date: Wed, 7 Dec 2005 01:54:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: ananth@in.ibm.com
Cc: anil.s.keshavamurthy@intel.com, linux-kernel@vger.kernel.org,
       prasanna@in.ibm.com
Subject: Re: [PATCH] kprobes: fix race in aggregate kprobe registration
Message-Id: <20051207015452.12f3d30b.akpm@osdl.org>
In-Reply-To: <20051207033025.GA2643@in.ibm.com>
References: <20051206051711.GA3206@in.ibm.com>
	<20051206131823.A8726@unix-os.sc.intel.com>
	<20051207033025.GA2643@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
>
> > Hi Ananth,
>  > 	How do you like this patch? Here the old entry
>  > will be replace with the new entry automically. 
> 
>  Your patch looks better.
> 
>  Andrew,
>  Anil's patch depends on the list.h updates currently in -mm
> 
>  > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  Acked-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Am feeling particularly uncreative.  Please resend with a changelog.
