Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbTI1Kys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTI1Kys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:54:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17073 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262534AbTI1Kyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:54:47 -0400
Message-ID: <3F76BDEC.7090701@pobox.com>
Date: Sun, 28 Sep 2003 06:54:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <1064737592.19950.1.camel@midux>
In-Reply-To: <1064737592.19950.1.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:
> CC [M]  drivers/net/wireless/arlan-main.o
> drivers/net/wireless/arlan-main.c: In function `init_module':
> drivers/net/wireless/arlan-main.c:1923: error: `probe' undeclared (first
> use in this function)
> drivers/net/wireless/arlan-main.c:1923: error: (Each undeclared
> identifier is reported only once
> drivers/net/wireless/arlan-main.c:1923: error: for each function it
> appears in.)
> make[3]: *** [drivers/net/wireless/arlan-main.o] Error 1
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2


already fixed... change headed to Linus soon.

