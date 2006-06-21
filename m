Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWFUQZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWFUQZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWFUQZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:25:50 -0400
Received: from xenotime.net ([66.160.160.81]:9160 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932222AbWFUQZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:25:49 -0400
Date: Wed, 21 Jun 2006 09:28:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kirill Smelkov <kirr@mns.spb.ru>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos in Documentation/memory-barriers.txt
Message-Id: <20060621092833.e4fbf920.rdunlap@xenotime.net>
In-Reply-To: <200606211120.56953.kirr@mns.spb.ru>
References: <200606211120.56953.kirr@mns.spb.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 11:20:55 +0400 Kirill Smelkov wrote:

> Thanks for excellent article!
> While reading it I discovered a few typos.
> 
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 4710845..638b686 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -282,7 +282,7 @@ Memory barriers come in four basic varie
>       A write barrier is a partial ordering on stores only; it is not required
>       to have any effect on loads.
>  
> -     A CPU can be viewed as as commiting a sequence of store operations to the
> +     A CPU can be viewed as commiting a sequence of store operations to the

committing

>       memory system as time progresses.  All stores before a write barrier will
>       occur in the sequence _before_ all the stores after the write barrier.
>  

---
~Randy
