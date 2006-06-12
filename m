Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWFLWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWFLWGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWFLWGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:06:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:3157 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932432AbWFLWGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:06:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XArME0Tgk6x1amuEpJX7gSSajMpCoPdNsib2LrSZweNlb/gjgY+geUCidcbD387ASKtAcFefIrKMRi2revKxWyc1gPZKYmYbuQDAdzuRJ1Zj0rcbQbVG0XjutsQzBZ6St0uAgMNLG2r5kBLoelu+ZRnetylxE6mFUH90oTQXHqI=
Message-ID: <9a8748490606121506w43c8a45yf44d0c4120ae80c@mail.gmail.com>
Date: Tue, 13 Jun 2006 00:06:52 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: nick@linicks.net
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Bernd Petrovitsch" <bernd@firmix.at>,
       "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <7c3341450606121410y7f2349e1y7d8ecf3f3873732@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bernd@firmix.at> <1150100843.26402.22.camel@tara.firmix.at>
	 <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl>
	 <7c3341450606121410y7f2349e1y7d8ecf3f3873732@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Nick Warne <nick.warne@gmail.com> wrote:
> I have been following this closely, and without getting into the
> discussion re SPF, I think one issue especially affecting LKML is the
> traffic.
>
> One (almost sure) fire way to stop the spam is to make a subscribed
> ML.  But people like myself cannot/have not the resource to take on
> the 200+ mails a day (how the kernel devs manage it, I don't know?).
>
> So I have subscribed via my gmail account to follow the mails, but
> then at least I can reply from my 'real address' and keep the thread
> intact (if you see what I mean).
>
> So, why not make the list a subscribe only list to SEND, but give an
> option to NOT receive any mail from the list unless CC'ed?
>

Making subscription to LKML a requirement would be a major barier for
people who just want to shoot off a bug report or similar but who do
not want to be subscribed (nor can be botherd to go through the
motions to subscribe, or perhaps can't work out how to subscribe)...
We want users to be able to submit bugreports to the list easily.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
