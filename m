Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVILTKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVILTKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVILTKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:10:06 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:59332
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932159AbVILTKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:10:05 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <netdev@vger.kernel.org>, "'Linus Torvalds'" <torvalds@osdl.org>,
       <ieee80211-devel@lists.sourceforge.net>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Git broken for IPW2200
Date: Mon, 12 Sep 2005 13:08:49 -0600
Message-ID: <005201c5b7cd$68c53320$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <4325CEFA.6050307@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> Care to send your .config?
> 
> 	Jeff

Jeff,

	http://lkml.org/lkml/2005/9/8/5

It was already fixed anyway, the thread is about 7 days old.

My config is at that URL.

.Alejandro
