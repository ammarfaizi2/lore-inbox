Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVCOCDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVCOCDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVCOCDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:03:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:62864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbVCOCDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:03:19 -0500
Date: Mon, 14 Mar 2005 18:02:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: coywolf@gmail.com
Cc: coywolf@sosdg.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] oom_kill fix
Message-Id: <20050314180258.271acfab.akpm@osdl.org>
In-Reply-To: <20050314181442.GA31020@everest.sosdg.org>
References: <20050314181442.GA31020@everest.sosdg.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
>
>  This oom_kill fix is to do mmput(mm) a bit earlier and returning 0 or 1
>  to indicate success or failure instead of returning mm_struct pointer. 

Why is this a "fix"?  What bug is it fixing?
