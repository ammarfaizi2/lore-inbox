Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932882AbWFMEvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbWFMEvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbWFMEvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:51:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33515
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932882AbWFMEvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:51:21 -0400
Date: Mon, 12 Jun 2006 21:51:32 -0700 (PDT)
Message-Id: <20060612.215132.42773560.davem@davemloft.net>
To: marc@perkel.com
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, matti.aarnio@zmailer.org,
       rlrevell@joe-job.com, folkert@vanheusden.com
Subject: Re: VGER does gradual SPF activation (FAQ matter) - Alternative
From: David Miller <davem@davemloft.net>
In-Reply-To: <448E36DE.1000906@perkel.com>
References: <20060611.115430.112290058.davem@davemloft.net>
	<448D7FB0.9070604@garzik.org>
	<448E36DE.1000906@perkel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Perkel <marc@perkel.com>
Date: Mon, 12 Jun 2006 20:54:06 -0700

> For what it's worth, I do front end spam filtering for domains and I 
> will volunteer to filter the spam for this list.

I don't know... the track record for your the email address
subscriptions for perkel.com on vger.kernel.org isn't all that great
:-)

! egrep perkel.com /var/log/del-log 
1126508199 davem marc@perkel.com linux-kernel user unknown
1127412390 davem marc@perkel.com linux-kernel redhat@perkel.com: Unrouteable address
1128312934 davem marc@perkel.com linux-kernel redhat@perkel.com: 550 REJECTED - User not found
1128627445 davem marc@perkel.com linux-kernel redhat@perkel.com: unrouteable address
1129247390 davem marc@perkel.com linux-kernel user unknown
1130807755 davem marc@perkel.com linux-kernel redhat@perkel.com: 550 REJECTED - User not found
1131385740 davem marc@perkel.com linux-kernel user unknown
1136501663 davem marc@perkel.com linux-kernel 421 Lost incoming connection: The error was detected in line 3.
