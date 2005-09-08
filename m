Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVIHPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVIHPpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIHPpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:45:38 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:2469
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932596AbVIHPph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:45:37 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Joe Bob Spamtest'" <joebob@spamtest.viacore.net>
Cc: <netdev@vger.kernel.org>, <ieee80211-devel@lists.sourceforge.net>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Git broken for IPW2200
Date: Thu, 8 Sep 2005 09:45:30 -0600
Message-ID: <003901c5b48c$580e7210$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
In-Reply-To: <432057D6.3010208@spamtest.viacore.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> IPW2200 requires a different ieee80211 stack, this can be had at
> ieee80211.sourceforge.net

Joe,

	The stack is already in mainline in Linus Git. I should not need to
download the ieee80211 from any place but compile with the one in the
kernel.

.Alejandro

>
>
> Alejandro Bonilla Beeche wrote:
> > Hi,
> >
> > 	Where does one report this? I was building Linus Git
> tree as per I
> > updated it at 09/07/2005 7:00PM PDT and got this while compiling.
> >
> > Where do I report this?
> >
> > Debian unstable updated at same time.
> >
> > it looks like ipw2200 is thinking that ieee80211 is not
> compiled in, but
> > I did select it as a module?
> >
> > drivers/net/wireless/ipw2200.c:6676: error: dereferencing pointer to

