Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWEOQZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWEOQZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEOQZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:25:45 -0400
Received: from xenotime.net ([66.160.160.81]:1421 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932361AbWEOQZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:25:44 -0400
Date: Mon, 15 May 2006 09:28:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
       mingo@elte.hu
Subject: Re: [PATCH -mm 01/02] Update rt-mutex-design.txt per Randy Dunlap
Message-Id: <20060515092810.004cfb63.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0605150437110.12114@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605150437110.12114@gandalf.stny.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 04:38:29 -0400 (EDT) Steven Rostedt wrote:

> @@ -160,12 +160,12 @@ Here we show both chains:
>                   F->L5-+
> 
>  For PI to work, the processes at the right end of these chains (or we may
> -also call the Top of the chain), must be equal to or higher in priority
> +also call the Top of the chain) must be equal to or higher in priority
   also call it the Top of the chain),

>  than the processes to the left or below in the chain.

Only that one small nit.  Otherwise looks nice.  Thanks.

---
~Randy
