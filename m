Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRB0COU>; Mon, 26 Feb 2001 21:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRB0COL>; Mon, 26 Feb 2001 21:14:11 -0500
Received: from [204.244.205.25] ([204.244.205.25]:19784 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129446AbRB0CN5>;
	Mon, 26 Feb 2001 21:13:57 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Reply-To: michael@linuxmagic.com
Organization: Wizard Internet Services
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
Date: Mon, 26 Feb 2001 19:24:19 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net> <0102261546570H.02007@mistress> <15002.58854.215318.882641@pizda.ninka.net>
In-Reply-To: <15002.58854.215318.882641@pizda.ninka.net>
MIME-Version: 1.0
Message-Id: <0102261924190K.02007@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, David S. Miller wrote:

>  > Also, I was looking into some RFC 1812 stuff. (Thanks for nothing Dave
>  > :) and was looking at 4.2.2.6 where it mentions that a router MUST
>  > implement the End of Option List option..  Havent' figured out where
>  > that is implememented yet..
>
> egrep "IPOPT_END" net/ipv4/ip_options.c
>
> You just aren't looking hard enough.

Was looking for IPOPT_EOL :) Forgot about it's reference..


-- 
"Catch the magic of Linux...."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
