Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751986AbWCMHlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWCMHlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 02:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWCMHlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 02:41:46 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:34845 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751986AbWCMHlp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 02:41:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wh8hz5gTmshqPoRySDCkU91b5wr2T6LY+eTjdB6qTzuIMCHtEOCxuTmBqcwewvZGLJfLgg1W5A6fhv6cnWPn6FCO8Ehqe2ai8DfhuuWd5AbpsWxvANhDab3Z5wtWMk/ipP9rvR87etf00uOYRmOvxuMKbqWQQJpgHoTVmFWXr7E=
Message-ID: <60bb95410603122341w74ca1d97k9bda52fd71d06d18@mail.gmail.com>
Date: Mon, 13 Mar 2006 15:41:44 +0800
From: "James Yu" <cyu021@gmail.com>
To: "Ben Dooks" <ben@fluff.org>
Subject: Re: weird behavior from kernel
Cc: "Willy Tarreau" <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060312213720.GB25816@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com>
	 <20060312084632.GB21493@w.ods.org>
	 <60bb95410603120125n24c3a283xe1fabeb255c8c59b@mail.gmail.com>
	 <20060312213720.GB25816@home.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a custom board I got, and the official 2.6 doesn't work on it. So
I have to use 2.4.

I tried -fno-strength-reduce option, and it doesn't seem to work though.
Still looking for solutions~


On 3/13/06, Ben Dooks <ben@fluff.org> wrote:
> On Sun, Mar 12, 2006 at 05:25:11PM +0800, James Yu wrote:
> > The major reason to choose 2.4.18 as my dev base is that the dev is
> > ment to be carried out on a custom ARM board, and there isn't any
> > 2.6's port available.
>
> What functionality do you need which is not in the current
> 2.6 kernel series?
>
> --
> Ben (ben@fluff.org, http://www.fluff.org/)
>
>   'a smiley only costs 4 bytes'
>


--
James
cyu021@gmail.com
