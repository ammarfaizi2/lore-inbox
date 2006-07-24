Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWGXO4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWGXO4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 10:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGXO4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 10:56:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3760 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932199AbWGXO4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 10:56:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JHFGkCnroE4zI6lhBDqEnxf6X4PMCA3rHpuijSJQmlFwgw54cdVOjjfGcBnjlzTY7e7Y2xIWHYcYN3BgfPpyopvdArN5RcvoAJh0wlVJCIVEV3itvhHOwUvbcH9oaENAfoefHb7X2ijS7qWaiSDZSGpRz7MhRZLFFfUcpuYK3g8=
Message-ID: <9a8748490607240756k75c3ceeepc110cdf216dd3e52@mail.gmail.com>
Date: Mon, 24 Jul 2006 16:56:27 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH] Add linux-mm mailing list for memory management in MAINTAINERS file
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Christoph Lameter" <clameter@sgi.com>, linux-mm@kvack.org,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>
In-Reply-To: <1153751558.4002.112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1153713707.4002.43.camel@localhost.localdomain>
	 <1153749795.23798.19.camel@lappy>
	 <1153751558.4002.112.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> Since I didn't know about the linux-mm mailing list until I spammed all
> those that had their names anywhere in the mm directory, I'm sending
> this patch to add the linux-mm mailing list to the MAINTAINERS file.
>
> Also, since mm is so broad, it doesn't have a single person to maintain
> it, and thus no maintainer is listed.  I also left the status as
> Maintained, since it obviously is.
>

How about having both the linux-mm list and linux-kernel listed?

> +MEMORY MANAGEMENT
> +L:     linux-mm@kvack.org
+L:     linux-kernel@vger.kernel.org
> +S:     Maintained
> +


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
