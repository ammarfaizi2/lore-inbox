Return-Path: <linux-kernel-owner+w=401wt.eu-S1751963AbWLNS2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWLNS2a (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWLNS2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:28:30 -0500
Received: from ns.firmix.at ([62.141.48.66]:52980 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbWLNS23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:28:29 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Bernd Petrovitsch <bernd@firmix.at>
To: =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200612141056.03538.hjk@linutronix.de>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
	 <200612140949.43270.duncan.sands@math.u-psud.fr>
	 <200612141056.03538.hjk@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Organization: Firmix Software GmbH
Date: Thu, 14 Dec 2006 18:34:18 +0100
Message-Id: <1166117658.28664.105.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.41 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:56 +0100, Hans-Jürgen Koch wrote:
[....]
> A small German manufacturer produces high-end AD converter cards. He sells
> 100 pieces per year, only in Germany and only with Windows drivers. He would
> now like to make his cards work with Linux. He has two driver programmers
> with little experience in writing Linux kernel drivers. What do you tell him?
> Write a large kernel module from scratch? Completely rewrite his code 
> because it uses floating point arithmetics?

Find a Linux kernel guru/company and pay him/them for
-) an evaluation if it is "better" (for whatever better means) to port
the driver
     or write it from scratch and
-) do the better thing.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

