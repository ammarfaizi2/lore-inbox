Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266773AbUAWWwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266776AbUAWWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:52:43 -0500
Received: from smtp.wp.pl ([212.77.101.160]:37034 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S266773AbUAWWwl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:52:41 -0500
Date: Fri, 23 Jan 2004 23:52:43 +0100
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
Message-Id: <20040123235243.420dc503.rmrmg@wp.pl>
In-Reply-To: <20040123233457.4400d715.rmrmg@wp.pl>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
	<20040123233457.4400d715.rmrmg@wp.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  Rafa³ 'rmrmg' Roszak <rmrmg@wp.pl> quote:

> begin  Marcelo Tosatti <marcelo.tosatti@cyclades.com> quote:
> 
> > Here goes -pre number 7 of 2.4.25 series.
> 
> #v+
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
> 2.4.25-pre7; fi depmod: *** Unresolved symbols in
[...]

I forgot set I2C bit-banging interfaces.
 Sorry for spam.

-- 
. JID: rmrmg(at)jabberpl(dot)org |   RMRMG   .
.           gg: #2311504         | signature .
.   mail: rmrmg(at)wp(dot)pl     |  version  .
.  registered Linux user 261525  |   0.0.3   .
