Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUIUUwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUIUUwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUIUUwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:52:11 -0400
Received: from mail.enyo.de ([212.9.189.167]:41743 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S268052AbUIUUwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:52:09 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, paul@clubi.ie, alan@lxorguk.ukuu.org.uk,
       vph@iki.fi, toon@hout.vanvergehaald.nl, admin@wolfpaw.net,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
References: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au>
	<873c1bjwwj.fsf@deneb.enyo.de>
	<20040921125645.05fafd5a.davem@davemloft.net>
	<871xgvie1y.fsf@deneb.enyo.de>
	<20040921132516.50c339c8.davem@davemloft.net>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 21 Sep 2004 22:51:40 +0200
In-Reply-To: <20040921132516.50c339c8.davem@davemloft.net> (David S. Miller's
	message of "Tue, 21 Sep 2004 13:25:16 -0700")
Message-ID: <87zn3jfiqr.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller:

> On Tue, 21 Sep 2004 22:04:41 +0200
> Florian Weimer <fw@deneb.enyo.de> wrote:
>
>> > Why would it be off by default?
>> 
>> Probably because PMTUD is just a DRAFT STANDARD,
>
> RFC1191 doesn't look like a draft to me.

It's not a draft document, but it's still a DRAFT STANDRD in the IETF
standards track, see RFC 3700.  (I wasn't shouting, I was using IETF
keywords. 8-)
