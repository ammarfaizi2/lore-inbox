Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWC2BMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWC2BMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWC2BMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:12:55 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:5060 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750746AbWC2BMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:12:54 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603290112.k2T1CkPj012879@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: klassert@mathematik.tu-chemnitz.de (Steffen Klassert)
Date: Tue, 28 Mar 2006 20:12:46 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       linux-kernel@vger.kernel.org (linux-kernel),
       akpm@osdl.org (Andrew Morton)
In-Reply-To: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steffen Klassert
  > >   Had several of these with git11
  > >   NETDEV WATCHDOG: eth0: transmit timed out
  > 
  > Is this for sure that these messages occured first time with git11?
  > There were no changes in the 3c59x driver between git10 and git11.
  > 
Tried the the same ftp with a 2.6.16 and get the time out. I'll try 2.6.15
to see what happens.
--
Pete Clements
