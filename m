Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbUKXO21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUKXO21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUKXO1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:27:00 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22793 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262679AbUKXOZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:25:04 -0500
Subject: Re: Difference wait_event_interruptible and interruptible_wait_on
From: Arjan van de Ven <arjan@infradead.org>
To: Hendrik Wiese <7.e.Q@syncro-community.de>
Cc: Davide Rossetti <davide.rossetti@roma1.infn.it>,
       LKLM <linux-kernel@vger.kernel.org>
In-Reply-To: <41A48FC2.6010701@syncro-community.de>
References: <41A478F2.3080004@syncro-community.de>
	 <41A48CFB.2010304@roma1.infn.it>  <41A48FC2.6010701@syncro-community.de>
Content-Type: text/plain
Message-Id: <1101306293.2811.18.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 24 Nov 2004 15:24:54 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 14:42 +0100, Hendrik Wiese wrote:

> 
> So what should such a condition be? What should be put there?

depends on your code.. do you have an URL to your driver source so that
people can see what you're asking ?


