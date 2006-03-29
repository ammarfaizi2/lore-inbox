Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWC2Cu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWC2Cu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWC2Cu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:50:58 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:26635 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750791AbWC2Cu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:50:57 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603290250.k2T2od8d001585@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: klassert@mathematik.tu-chemnitz.de (Steffen Klassert)
Date: Tue, 28 Mar 2006 21:50:39 -0500 (EST)
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
Tried 2.6.15 and could not get a timed out condition.  Looks like
that defect is between 15 and 16 in my case.  

Be glad to do any testing that I can.

--
Pete Clements
