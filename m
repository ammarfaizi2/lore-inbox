Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSIZDOc>; Wed, 25 Sep 2002 23:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262155AbSIZDOb>; Wed, 25 Sep 2002 23:14:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262154AbSIZDOb>;
	Wed, 25 Sep 2002 23:14:31 -0400
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1243.4.64.197.173.1033010387.squirrel@www.osdl.org>
Date: Wed, 25 Sep 2002 20:19:47 -0700 (PDT)
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
To: <gerg@snapgear.com>
In-Reply-To: <3D927278.6040205@snapgear.com>
References: <20020925151943.B25721@parcelfarce.linux.theplanet.co.uk>
        <3D927278.6040205@snapgear.com>
X-Priority: 3
Importance: Normal
Cc: <willy@debian.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * You're defining CONFIG_* variables in the .c file.  I don't know
>> whether
>>   this is something we're still trying to avoid doing ... Greg, you
>> seem to be CodingStyle enforcer, what's the word?
>
> I missed this the first time through :-)
> I am not sure what you mean, CodingStyle enforcer?
> Can you elaborate for me?


Willy is talking about Greg Kroah-Hartman here, not you.

~Randy



