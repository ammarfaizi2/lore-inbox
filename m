Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291659AbSBNN7M>; Thu, 14 Feb 2002 08:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291660AbSBNN7C>; Thu, 14 Feb 2002 08:59:02 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:27870 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S291659AbSBNN6v>; Thu, 14 Feb 2002 08:58:51 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: Linux 2.4.18-pre9-mjc2
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Thu, 14 Feb 2002 08:58:55 -0500
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net> <20020213211943.A25918@work.bitmover.com>
Organization: me
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020214135855.A6E234698@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> On Wed, Feb 13, 2002 at 11:58:28PM -0500, Michael Cohen wrote:
>> [ I am now using bitkeeper, and my bk tree is available at
>> bk://ohdarn.net/linux-mjc.  it is cloned from linus's 2.4 tree so
>> please, please, please clone from him and pull from me. ]
> 
> Just in case people need a reminder, you would do this:
> 
> bk clone bk://linux.bkbits.net/linux-2.4
> cd linux-2.4
> bk pull bk://ohdarn.net/linux-mjc

oscar% bk clone -q linux-2.4 linux-mjc-edt
oscar% cd linux-mjc-edt
oscar% bk pull bk://ohdarn.net/linux-mjc
Nothing to pull from bk://ohdarn.net/linux-mjc
oscar%

Where linux-2.4 is a local clone of linux-2.4.  Why
does it find nothing to pull ?

TIA
Ed Tomlinson
