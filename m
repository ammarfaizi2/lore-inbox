Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCaSYC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUCaSYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:24:02 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:64745 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262266AbUCaSX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:23:59 -0500
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip
	400000000062ada1, isr 0000020000000008
From: Alex Williamson <alex.williamson@hp.com>
To: davidm@hpl.hp.com
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       ulrich.windl@rz.uni-regensburg.de,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16491.2184.253165.545651@napali.hpl.hp.com>
References: <406AE0D5.10359.1930261@localhost>
	 <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
	 <16491.2184.253165.545651@napali.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1080757433.2326.32.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 11:23:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 11:06, David Mosberger wrote:

> If the messages appear with a frequency of less than 5 messages/5
> seconds, then there is certainly no performance issue and you may want
> to just turn off the messages.

   But if you do get them at the maximum rate for a computational
application, performance could be _severely_ impacted (ie. orders of
magnitude).

	Alex


