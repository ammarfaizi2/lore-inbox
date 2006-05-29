Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWE2Qg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWE2Qg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWE2Qg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 12:36:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:51149 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751132AbWE2Qg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 12:36:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MhSbubUBSiS8NRsu0i+FXAM8gfUoE6Cirhna5nYuPMwukNvhq0vB2zn4JG3aB5N7yYIYA+nkmrESoX5c4r7jSNLZN7YNY0TaJDgIKqxllVYyCFj6R0zWiXLZxEDFBcT5cS8RRHjH7WODZ5O7GslXLqcb3SzGq8Urq4zAuWRTYQ8=
Message-ID: <35fb2e590605290936s35b0adf9r33b0c7c97ab0baa8@mail.gmail.com>
Date: Mon, 29 May 2006 17:36:25 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Stefan Smietanowski" <stesmi@stesmi.com>
Subject: Re: [ANNOUNCE] Linux Device Driver Kit available
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4479E1A1.1030006@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524232900.GA18408@kroah.com>
	 <35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com>
	 <4479E1A1.1030006@stesmi.com>
X-Google-Sender-Auth: 4100fac1e0faa0f6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, Stefan Smietanowski <stesmi@stesmi.com> wrote:

> Jon Masters wrote:

> > * Bootable Damn Small Linux (DSL) or similar.
> > * cached LXR (obviously with reduced function).

> For what platform? MIPS ? Alpha ? x86_64 ? i386 ? ARM ?

You missed PowerPC and a few others... :P

I get the point, but we all know that many people getting into Linux
from some other background often are using PC based platforms. It's
not worth ignoring that just because Linux supports many alternatives
and we personally use them. I personally use my Powerbooks for much of
my day-to-day Linux, but I'm weird anyway.

> Unless you can make it platform-agnostic (or supporting all
> platforms Linux does) ..

No point bothering, just do an x86 one and someone will do a variant!
:P Then they'll end up starting an entire community and figuring out
which platforms should be first class citizens for support. Before
Greg even realizes it, he'll have started a whole new Linux
distribution all by releasing a DDK. No I'm not being serious.

Jon.
