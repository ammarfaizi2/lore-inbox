Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUCaSiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUCaSiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:38:00 -0500
Received: from palrel13.hp.com ([156.153.255.238]:23722 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262328AbUCaSh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:37:57 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16491.4097.776873.770830@napali.hpl.hp.com>
Date: Wed, 31 Mar 2004 10:37:53 -0800
To: Alex Williamson <alex.williamson@hp.com>
Cc: davidm@hpl.hp.com, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       ulrich.windl@rz.uni-regensburg.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip
	400000000062ada1, isr 0000020000000008
In-Reply-To: <1080757433.2326.32.camel@patsy.fc.hp.com>
References: <406AE0D5.10359.1930261@localhost>
	<200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
	<16491.2184.253165.545651@napali.hpl.hp.com>
	<1080757433.2326.32.camel@patsy.fc.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 31 Mar 2004 11:23:53 -0700, Alex Williamson <alex.williamson@hp.com> said:

  Alex> On Wed, 2004-03-31 at 11:06, David Mosberger wrote:
  >> If the messages appear with a frequency of less than 5 messages/5
  >> seconds, then there is certainly no performance issue and you may want
  >> to just turn off the messages.

  Alex> But if you do get them at the maximum rate for a computational
  Alex> application, performance could be _severely_ impacted (ie. orders of
  Alex> magnitude).

Good point.

	--david
