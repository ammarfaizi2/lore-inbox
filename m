Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbSJBROc>; Wed, 2 Oct 2002 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263174AbSJBROc>; Wed, 2 Oct 2002 13:14:32 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25302 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S263172AbSJBRO2>; Wed, 2 Oct 2002 13:14:28 -0400
Date: Wed, 02 Oct 2002 10:18:53 -0700
From: Ken Savage <kens1835@shaw.ca>
Subject: Re: 3ware Escalade 7500 init problems on 2.4.19
In-reply-to: <1033578103.8610.12.camel@plokta.s8.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200210021018.53312.kens1835@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
User-Agent: KMail/1.4.1
References: <200210020859.54621.kens1835@shaw.ca>
 <1033578103.8610.12.camel@plokta.s8.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 2, 2002 10:01, Bryan O'Sullivan wrote:

> The driver that ships with 2.4.19 isn't the most recent, though I doubt
> there's anything in the up-to-date driver that should make a difference.

'diff'ing the drivers, you can see a tiiiiny difference.  As you said, nothing
that should make a difference.  In either case, both versions of the driver
remain unhappy with the card, failing to initialize it.

> The error message you report is replicated in several spots within the
> driver, so it's not useful in itself.

What additional information would be of assistance?

Ken
