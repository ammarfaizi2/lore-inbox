Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTFYTzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbTFYTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:55:25 -0400
Received: from palrel13.hp.com ([156.153.255.238]:64919 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265002AbTFYTzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:55:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16122.380.388537.384614@napali.hpl.hp.com>
Date: Wed, 25 Jun 2003 13:09:32 -0700
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: davidm@hpl.hp.com, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <20030625215847.A12212@ucw.cz>
References: <20030618013114.A23697@ucw.cz>
	<BKEGKPICNAKILKJKMHCAIECMEHAA.Riley@Williams.Name>
	<16121.55803.509760.869572@napali.hpl.hp.com>
	<20030625215847.A12212@ucw.cz>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 Jun 2003 21:58:47 +0200, Vojtech Pavlik <vojtech@suse.cz> said:

  Vojtech> Actually, I think it should be the other way around:

Ah, yes, that looks better for x86.

	--david
