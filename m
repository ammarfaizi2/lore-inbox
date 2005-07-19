Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVGSByn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGSByn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 21:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVGSBym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 21:54:42 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:29736 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261849AbVGSBym convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 21:54:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EI7YdTfzL9OYEQeIwWRvRdwj2ZcEEgq/haPaNgUp3LIyKPm2jniWH2BFbuvYQxlNFY3y+4jJ6hVKj/GDAOBKuulM4efY4aaG91DKCcNQDb1s6O1o5tB3lr5c8FMmC9S1/U2BM7U+jZVtA2mjcWUlTVDkyt5iE3k4g2LC2pqMTOo=
Message-ID: <9a8748490507181854416804c8@mail.gmail.com>
Date: Tue, 19 Jul 2005 03:54:13 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Parminder Chhabra <parminderchhabra@email.com>
Subject: Re: repeated Oops on Kernel 2.6.12.2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050718042523.275E41CE304@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050718042523.275E41CE304@ws1-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/05, Parminder Chhabra <parminderchhabra@email.com> wrote:
> Hi,
> 
> I get repeated Oops messages on 2.6.12.2. I get the message on inserting a

Have you tested a more recent kernel like 2.6.13-rc3 or
2.6.13-rc3-git4 or 2.6.13-rc3-mm1 to see if the problem is already
solved?

> module that spawns a kernel thread to perform a task on a group of packets.

Perhaps you could provide the code for that module somewhere?

Sorry I can't be of more help.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
