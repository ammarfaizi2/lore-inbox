Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUBMJKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUBMJKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:10:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:2489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266850AbUBMJKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:10:39 -0500
Date: Fri, 13 Feb 2004 01:10:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: mhf@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-Id: <20040213011012.12645046.akpm@osdl.org>
In-Reply-To: <XFMail.20040213095802.pochini@shiny.it>
References: <200402130615.10608.mhf@linuxmail.org>
	<XFMail.20040213095802.pochini@shiny.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini <pochini@shiny.it> wrote:
>
> 
> On 12-Feb-2004 Michael Frank wrote:
> > Here is Codingstyle updated.
> 
> > +The limit on the length of lines is 80 columns and this is a hard limit.
> 
> Well, I think this requirement is a bit silly IMHO. How many of us
> do usually code in a 80x25 terminal screen nowadays ?
> 

"I think the 90x25 requirement is silly"

"I think the 100x25 requirement is silly"

And so it goes.  You get into an xterm arms race wherein everyone has to
make their terminal as wide as the widest guy so anyone can get any work
done.

Yes, 80 cols sucks and the world would be a better place had CodingStyle
mandated 96 columns five years ago.  But it didn't happen.


