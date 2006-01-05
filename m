Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWAEW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWAEW10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWAEW10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:27:26 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:34567 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751445AbWAEW1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:27:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9S5B4nMGPg5eHMoaeQfbV8hYanTf8P6XYuiczXiUiwunuyoxwxWX6O7RRJq1SK7OgClsnlzG3V2Dhno2pM0fBQh6GFGbMLWlnUq9LfncEhbAqUQtaazd3s/ZOPq1c4/Si/vuA0tIuuIUc3Kno3nUFxkViKH4gtiglcGHr5RQds=
Message-ID: <9a8748490601051427x1ab06565o2e7b76a28f2b42fc@mail.gmail.com>
Date: Thu, 5 Jan 2006 23:27:23 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: } <grundig@teleline.es>
Subject: Re: 80 column line limit?
Cc: kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060105154330.da1016fc.grundig@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060105130249.GB29894@vrfy.org>
	 <9a8748490601050527x407ff85dref45774d5eb131d9@mail.gmail.com>
	 <20060105154330.da1016fc.grundig@teleline.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, } <grundig@teleline.es> wrote:
> El Thu, 5 Jan 2006 14:27:23 +0100,
> Jesper Juhl <jesper.juhl@gmail.com> escribió:
>
> > I very often work in console (or xterm) and editing kernel code. Files
> > with lines >80 col. are quite annoying to have to scroll left/right in
>
> I wonder why (we) people keeps working (and writing emails) with a 80
> cols limit - monitors are BIG these days and even the crappiest
> graphic card can do better than 80x25 even without using fbcon. Is not

I'm well aware that my hardware can easily do more than 80 columns,
but that's simply not as pleasant to read. Even in X I usually keep my
xterms to 80 columns and with a resonably large font so I don't have
to strain my eyes too much when reading.

> that breaking the 80-cols rules is annoying, working with such setups
> are painful even to run basic shell scripts. These days hardware can do
> better things than 80-col consoles even for console users.
>
It's not about hardware capabilities, it's about readability.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
