Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUBKAOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 19:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBKAOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 19:14:40 -0500
Received: from palrel10.hp.com ([156.153.255.245]:51884 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263539AbUBKAOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 19:14:38 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16425.29675.430856.444153@napali.hpl.hp.com>
Date: Tue, 10 Feb 2004 16:14:35 -0800
To: Sebastian Henschel <linux@kodeaffe.de>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] URL addition tuxmobil.org
In-Reply-To: <20040210121351.GA19769@fuchi>
References: <20040210121351.GA19769@fuchi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 10 Feb 2004 13:13:51 +0100, Sebastian Henschel <linux@kodeaffe.de> said:

  Sebastian> hi there...  attached is a cosmetic patch for
  Sebastian> arch/ia64/Kconfig which introduces the URL of
  Sebastian> tuxmobil.org as an alternative to linux-on-laptops.com.

I'd be much more interested in a patch which consolidated the various
platforms to all use kernel/power/Kconfig so this info doesn't have to
be replicated half a dozen times.

	--david
