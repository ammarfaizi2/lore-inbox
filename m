Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTAYAQI>; Fri, 24 Jan 2003 19:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbTAYAQI>; Fri, 24 Jan 2003 19:16:08 -0500
Received: from mail.zmailer.org ([62.240.94.4]:48772 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S265895AbTAYAQH>;
	Fri, 24 Jan 2003 19:16:07 -0500
Date: Sat, 25 Jan 2003 02:25:19 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Bradford <john@grabjohn.com>
Cc: yiding_wang@agilent.com, linux-kernel@vger.kernel.org
Subject: Re: Server down?
Message-ID: <20030125002519.GO787@mea-ext.zmailer.org>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D54F94@axcs03.cos.agilent.com> <200301231902.h0NJ2Z6s001955@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301231902.h0NJ2Z6s001955@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 07:02:35PM +0000, John Bradford wrote:
> > For some reason, I don't receive mail send to linux kernel anymore.
> > Is that a server problem or I need to do the subscribe again.  It
> > happened fron yesterday.
> 
> The list server probably de-subscribed you.  Try re-subscribing.

Lets see what logs tell:

    @grabjohn.com linux-kernel relaying denied
  yiding_wang@agilent.com linux-kernel user unknown

Agilent had front-end system loosing its database/mind temporarily
(but 1 hour "temporary" is 10-60 bounces depending on the hour...)

Cases of "relaying denied" (wording varies) are fairly easy to understand.
Cases where systems have temporary insanities are most difficult to analyze...

> John.

/Matti Aarnio
