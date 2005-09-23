Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVIWWzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVIWWzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVIWWzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:55:01 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:48799 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbVIWWzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:55:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uLCve0itNKjDIT4P98fTD/bYYr+AfNvoPvD5SpJ5xEKeZVucGheh0JdFGZpf/f0WS7clK0UhQxhDarU0/et1vfoxH0NrqzMjjHjvtEQBUKsE3BnYv0NPpCgraCt2riPw+4TtDGiKIGUYsfUwqeQ+crpERlFSIiZoklJis2G2lHE=
Date: Sat, 24 Sep 2005 03:05:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Ingo Oeser <ioe@informatik.tu-chemnitz.de>,
       Jason Thomas <jason@topic.com.au>,
       Matthew Hawkins <matt@mh.dropbear.id.au>
Subject: Re: [PATCH 1/3] lib/string.c cleanup : whitespace and CodingStyle cleanups
Message-ID: <20050923230521.GA6915@mipter.zuzino.mipt.ru>
References: <200509232344.26044.jesper.juhl@gmail.com> <200509232348.45030.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509232348.45030.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 11:48:44PM +0200, Jesper Juhl wrote:
> Whitespace and CodingStyle cleanups for lib/string.c
> 
> Removes some blank lines, removes some trailing whitespace, adds spaces 
> after commas and a few similar changes.

> -char * strcpy(char * dest,const char *src)
> +char *strcpy(char *dest, const char *src)
	^^^

Why? Seriously.

