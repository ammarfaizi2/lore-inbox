Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275193AbTHAH6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 03:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275194AbTHAH6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 03:58:19 -0400
Received: from c2mailgwalt.mailcentro.com ([207.183.238.112]:10467 "EHLO
	c2mailgwalt.mailcentro.com") by vger.kernel.org with ESMTP
	id S275193AbTHAH6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 03:58:18 -0400
X-Version: Mailcentro(english)
X-SenderIP: 80.58.9.46
X-SenderID: 7831070
From: "Jose Luis Alarcon" <jlalarcon@chevy.zzn.com>
Message-Id: <F759403221D30FB40B5B2C15610E4950@jlalarcon.chevy.zzn.com>
Date: Fri, 1 Aug 2003 09:58:05 +0200
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: xfs problems (2.6.0-test2)
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi there,
>
>What XFS blocksize are you using, and what is your page size?
>There are known issues when using blocksizes smaller than the
>page size in the 2.6 XFS code at the moment.
>

  Hi Nathan, and congratilations for the SGI work.

  Now i have a Mandrake with the 2.5.75 kernel and XFS in
all partitions. The filesystem looks work very well.

  I am planning install 2.6.0-test3 when it comes and i wanna
ask you: how can i know what blocksize am i using?, and how
know what is the page size in my system?.

  Thanks you, very much, in advance.

  Regards.

  Jose.


http://linuxespana.scripterz.org

FreeBSD RELEASE 4.8.
Mandrake Linux 9.1 Kernel 2.5.75 XFS.
Registered BSD User 51101.
Registered Linux User #213309.
Memories..... You are talking about memories. 
Rick Deckard. Blade Runner.


Get your Free E-mail at http://chevy.zzn.com
___________________________________________________________
Get your own Web-based E-mail Service at http://www.zzn.com
