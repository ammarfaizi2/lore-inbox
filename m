Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270767AbTGNT3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTGNT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:29:22 -0400
Received: from c2mailgwalt.mailcentro.com ([207.183.238.112]:28035 "EHLO
	c2mailgw03.mailcentro.net") by vger.kernel.org with ESMTP
	id S270767AbTGNT3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:29:09 -0400
X-Version: Mailcentro 1.0
X-SenderIP: 80.58.9.46
X-SenderID: 7831070
From: "Jose Luis Alarcon" <jlalarcon@chevy.zzn.com>
Message-Id: <A327EBA09DA97C44682F5323798CACD7@jlalarcon.chevy.zzn.com>
Date: Mon, 14 Jul 2003 21:43:47 +0200
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpmsinstalled)
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---- Begin Original Message ----

Trever L. Adams wrote:
> OK, I now get past the initialization of the 3c920.  However, now it
> hangs (sak enabled, sak doesn't work... completely dead) when eth0 tries
> to come up.  I have IPv6 enabled (the router does 6to4, this isn't the
> router), I don't believe I have any firewall stuff on this box, it does
> dhcp for IPv4 address and ntp time.


hmmm... do you have the latest modutils installed?

---- End Original Message ----


  Jeff...are you saying that modutils-2.4.25 are good for run
the 2.6.0-test1 kernel?. My idea was that we need the 
module-init-tools....

  Thanks very much, in advance.

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
