Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTITOO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 10:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbTITOO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 10:14:57 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:40630 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261893AbTITOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 10:14:56 -0400
Subject: Re: ftape new web address
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Claus-Justus Heine <heine@instmath.rwth-aachen.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <20030920100331.GO9599@kiwi.hjbaader.home>
References: <20030920100331.GO9599@kiwi.hjbaader.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064067139.21728.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 20 Sep 2003 15:12:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-20 at 11:03, Hans-Joachim Baader wrote:
> Hi,
> 
> the attached patch for 2.4.22 fixes the web address of the ftape driver.
> Why does the kernel still contain version 3.0.4 when 4.0.4a is the
> current one?

It never got merged for 2.4. Long history. For 2.6 if you want to pick
up the updates and merge them go for it although floppy tape is kind of
dead technology now

