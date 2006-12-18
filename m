Return-Path: <linux-kernel-owner+w=401wt.eu-S1754164AbWLRPil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbWLRPil (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbWLRPil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:38:41 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:19132 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbWLRPik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:38:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CWWspOyhpox4DFi5RXkooCrzTUK2W5FWkzzrXMCsOAH9BEcWuwJvP1cH/D+gomZcmCaoJ5iISvGlnxiwj7EwbFCkfY3773p84LmqwPQL0R/XQi1SCN5hVctKex4906zQTkFahgfClNOT5j8QJZRYz41QkcoNyAkiEGulZ3PXMkg=
Message-ID: <161717d50612180738y4feec39dp5d1d090409a9e074@mail.gmail.com>
Date: Mon, 18 Dec 2006 10:38:38 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: GPL only modules
Cc: "Alexandre Oliva" <aoliva@redhat.com>, "Ricardo Galli" <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612161927.13860.gallir@gmail.com>
	 <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	 <orwt4qaara.fsf@redhat.com>
	 <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
X-Google-Sender-Auth: 2c9898ad9bcaf650
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Linking does have one thing that it implies: it's maybe a bit "closer"
> relationship between the parts than "mkisofs" implies. So there is
> definitely a higher _correlation_ between "derived work" and "linking",
> but it's really a correlation, not a causal relationship.
>
> But it wasn't the "act of linking" that caused
> that to happen, but simply the fact that they were part of a bigger whole,
> and were meaningless apart from each other.

I think this is the key, both with libraries and w/ your book example
below; the concept of independant "meaning." If your code doesn't do
whatever it is supposed to do _unless_ it is linked with _my_ code,
then it seems fairly clear that your code is derivative of mine, just
as your sequel to my novel (or your pages added onto my book) don't
"mean" anything if someone hasn't read mine.

>
> Think of this in the sense of a book. Does binding pages together create a
> "derived work"? Not always: you can have anthologies (which are
> *aggregations* of works with *independent* copyright), and the binding of
> pages together didn't really do anything to the independent pieces. But
> clearly, if you're talking about individual pages in one story, then each
> individual page is not an independent work in itself.

Dave
