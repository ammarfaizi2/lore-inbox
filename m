Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTDJQf2 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTDJQf2 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:35:28 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:5008 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264097AbTDJQf1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:35:27 -0400
Date: Thu, 10 Apr 2003 10:44:50 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: alan@lxorguk.ukuu.org.uk, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges
Message-ID: <524390000.1049993090@aslan.btc.adaptec.com>
In-Reply-To: <20030410132055.1745749c.skraw@ithnet.com>
References: <200304082124_MC3-1-3399-FBD0@compuserve.com>	<1049886804.9901.19.camel@dhcp22.swansea.linux.org.uk>	<194120000.1049909641@aslan.btc.adaptec.com> <20030410132055.1745749c.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I am probably one of the victims of these differing opinions, can anyone
> tell me where to get a really-known-to-work aic-driver for 2.4? I am
> experiencing zapping-black events while reading from a SDLT drive (writing to
> it does fine).

The best way to get to a resolution on aic7xxx issues is to use the
drivers from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

And provide as much information about the problem as you can.  In this
case, I'm at a loss for what a "zapping-black event" is.

--
Justin

