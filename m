Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136495AbREDUCS>; Fri, 4 May 2001 16:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136492AbREDUCI>; Fri, 4 May 2001 16:02:08 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:59374 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S136495AbREDUB6>;
	Fri, 4 May 2001 16:01:58 -0400
Message-ID: <3AF30A7E.DC8D9914@pcsystems.de>
Date: Fri, 04 May 2001 22:01:02 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE added a new feature: disable pc speaker
Content-Type: multipart/mixed;
 boundary="------------BAA9DCC7EB9347EC0A33A6F2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BAA9DCC7EB9347EC0A33A6F2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------BAA9DCC7EB9347EC0A33A6F2
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3AF309FA.24767C26@pcsystems.de>
Date: Fri, 04 May 2001 21:58:50 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: added a new feature: disable pc speaker
In-Reply-To: <8340.988979784@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Keith Owens wrote:

> On Fri, 04 May 2001 13:37:08 +0200,
> Nico Schottelius <nicos@pcsystems.de> wrote:
> >I have searched a long time for a method to disable the internal
> >speaker for every application, every daemon and so on.
>
> Userspace problem, userspace fix.

This sounds good :) ... but ->

>
>   setterm -blength 0 (text)
>   xset b 0 (X11)

This was what I tried and used before. Aplications like Netscape
get a beep throught it, although running xset b 0 or xset b off.



--------------BAA9DCC7EB9347EC0A33A6F2--

