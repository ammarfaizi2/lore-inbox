Return-Path: <linux-kernel-owner+w=401wt.eu-S1754315AbWLRRXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbWLRRXG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbWLRRXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:23:06 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:27920 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbWLRRXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:23:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FPtg87V1qXSvlYejAOXauXUdpapmEQIAnVf4f9PeYiZ5KWRaAdCx/cuCRcqD51ArOXXxPllUf1ZDBYkWDRGHymEwNYJcd01p8bcMqoRUniixyObV94FAqBMrbWLg9+FwIpQaU7sRRNUYzlOvh4v84Ng/fOstHzY7MUBCv6K9Zmg=
Message-ID: <161717d50612180923h6ae59ff1y1ef01d4a6dc2caed@mail.gmail.com>
Date: Mon, 18 Dec 2006 12:23:03 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Theodore Tso" <tytso@mit.edu>, "Dave Neuer" <mr.fred.smoothie@pobox.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Alexandre Oliva" <aoliva@redhat.com>,
       "Ricardo Galli" <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <20061218170222.GB18255@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612161927.13860.gallir@gmail.com>
	 <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	 <orwt4qaara.fsf@redhat.com>
	 <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
	 <161717d50612180738y4feec39dp5d1d090409a9e074@mail.gmail.com>
	 <20061218170222.GB18255@thunk.org>
X-Google-Sender-Auth: d1c0cdf16ae85b7a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Dec 18, 2006 at 10:38:38AM -0500, Dave Neuer wrote:
> > I think this is the key, both with libraries and w/ your book example
> > below; the concept of independant "meaning." If your code doesn't do
> > whatever it is supposed to do _unless_ it is linked with _my_ code,
> > then it seems fairly clear that your code is derivative of mine, just
> > as your sequel to my novel (or your pages added onto my book) don't
> > "mean" anything if someone hasn't read mine.
>
> For myself, I believe we actually get the largest amount of
> programming freedom if we use a very tightly defined definition of
> derived code, and not try to create new expansive definitions and try
> to ram them through the court system or through legislatures.  In the
> end, we may end up regretting it.

To be sure, we as programmers will have the most freedom if there is
no form of intellectual property protection for software at all
(imagine all of those Renaissance publishers whose sensibilities would
have been quite shocked by the suggestion that their distribution of
some author's work for a small fee was somehow "theft").

It's less clear to me that a more expansive "we" will be equally well
served, freedom-wise, by less protection though I'm very sympathetic
to the argument.

>                                                 - Ted
>

Dave
