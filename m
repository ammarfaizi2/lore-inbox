Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932908AbWFMFyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWFMFyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWFMFyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:54:17 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:58066 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932908AbWFMFyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=CaaftAlNZJ89PoSK2fgIldU+l3hiUX/3vzOB77ufQcQcdX451GJbbi7a5++/7Loe;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <02f401c68ead$c69815a0$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, <nick@linicks.net>,
       "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Bernd Petrovitsch" <bernd@firmix.at>,
       "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
Subject: Re: VGER does gradual SPF activation (FAQ matter) 
Date: Mon, 12 Jun 2006 22:54:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120b56ff735b21b180010b1f66e5760a736b0a2d63a8262ae17350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Horst von Brand" <vonbrand@inf.utfsm.cl>

> jdow <jdow@earthlink.net> wrote:
> 
> [...]
> 
>> Greylist those who have not subscribed.
> 
> That is not easy to do.

Somebody needs to write the code to make it easy to do for a list
server. It should not be hard to do.

>>                                         Let their email server try
>> again in 30 minutes. For those who are not subscribed it should not
>> matter if their message is delayed 30 minutes. And so far spammers
>> never try again.
> 
> Wrong. Greylisting does stop an immense amount of spam here, but a lot
> comes through.

So if it's not perfect it's not worth doing at all, eh? Yet you think
SPF, which is FAR less suited as a spam preventative, is a single
point solution. Double think was supposed to have come and gone in
1984, I thought.

{^_^}
