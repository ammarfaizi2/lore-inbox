Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbRETPem>; Sun, 20 May 2001 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbRETPec>; Sun, 20 May 2001 11:34:32 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:19979 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262040AbRETPeQ>;
	Sun, 20 May 2001 11:34:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up 
In-Reply-To: Your message of "Sun, 20 May 2001 11:18:56 -0400."
             <20010520111856.C3431@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 01:34:09 +1000
Message-ID: <5800.990372849@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001 11:18:56 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>David Woodhouse <dwmw2@infradead.org>:
>>                              The dependencies in CML1 are (supposed to
>> be) absolute - the 'advisory' dependencies you're adding are arguably a
>> useful feature, but please don't make it possible to confuse the two, and
>> please do make sure it's possible to disable the latter form.
>
>I don't understand this request.  I have no concept of `advisory' dependencies.
>What are you talking about?   Is my documentation horribly unclear?

People read documentation?  No chance.

Some people have got it into their heads that the "Aunt Tillie" method
of configuration will be the only one allowed.  They do not realise
that this is the novice method, experts can still do what they like.
For dwm's "advisory dependencies", read novice mode, and of course it
can be overridden by people who know what they are doing.

