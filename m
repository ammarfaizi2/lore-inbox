Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWAPVIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWAPVIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAPVIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:08:34 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:61630 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751212AbWAPVId convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:08:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kM/CGSSEw+FNmvAu2wwe2mxAFG1GZ6ioXH4yyqh4LM8fgv4+FVXv2R/HQObMSD01DnoCfdaZrwDzs6/kl7Ll9UeDqPboCjnFGVj3TwHwDONrmmJufhfuu0CKgw7NdpCBQWcXU3TNSFGSOTmbYLR13I0nGF8JzzuSYLjbq2X9DJw=
Message-ID: <9a8748490601161308g5f941c30o870042e6d9811c58@mail.gmail.com>
Date: Mon, 16 Jan 2006 22:08:29 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andy Gospodarek <andy@greyhouse.net>
Subject: Re: [patch] networking ipv4: remove total socket usage count from /proc/net/sockstat
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
In-Reply-To: <bdfc5d6e0601161255w4e1a6ac5oaa6844a6e1bbd0aa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116200432.GB14060@gospo.rdu.redhat.com>
	 <1137442446.19444.20.camel@mindpipe>
	 <bdfc5d6e0601161225h53554b1ahde794af93af52bdf@mail.gmail.com>
	 <9a8748490601161235k2defec82sa51a17e4fc14b22f@mail.gmail.com>
	 <bdfc5d6e0601161255w4e1a6ac5oaa6844a6e1bbd0aa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Andy Gospodarek <andy@greyhouse.net> wrote:

[could you *please* not top post? It's pretty annoying]

> Jesper,
>
> Thanks for the explanation.  Your reasoning makes sense.  I will

I'm glad you found it useful.

> consider other ways to solve my current problem and post a patch that
> doesn't "break userspace" if necessary.
>
Maybe if you described "your current problem" someone could suggest a
solution...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
