Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVDRK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVDRK5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 06:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVDRK5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 06:57:01 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:64388 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262028AbVDRK46 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 06:56:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PAvfycnx/4a4gEqp1jVCTBF9XljU+SiuUJIgMhJ91K2vFq5R6B/amZNx0BjTw9W0JPtUEKj0d4vKjWFEtAtrrawxK1+3Bqf15+oLqM1IHfgf8L+rLJxP3PqcyCVkevseqZjsCYU2DAqKG/txXOJ6DMFXu7wH7eSVNs+v4nucQBY=
Message-ID: <68b6a2bc05041803561621ddd6@mail.gmail.com>
Date: Mon, 18 Apr 2005 13:56:57 +0300
From: Ehud Shabtai <eshabtai.lkml@gmail.com>
Reply-To: Ehud Shabtai <eshabtai.lkml@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Need some help to debug a freeze on 2.6.11
Cc: Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0504181220090.2522@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <68b6a2bc050418000619a552de@mail.gmail.com>
	 <1113818666.357.17.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0504181215590.2522@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.62.0504181220090.2522@dragon.hyggekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> On Mon, 18 Apr 2005, Jesper Juhl wrote:
> 
> > On Mon, 18 Apr 2005, Alexander Nyberg wrote:
> >
> > > Sounds like a job for Documentation/networking/netconsole.txt
> > >
> > or Documentation/serial-console.txt
> >
> Console on line printer would also be an option.

I don't have any printer port cables, so I guess I prefer to try netconsole.

I'm using wireless lan (Intel's ipw2100), would netconsole work on
wlan interface?
As an alternative, can I configure netconsole for my ethernet port and
only really connect it, after I get the freeze?

Thanks for your help.
