Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUAMTwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUAMTwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:52:44 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:41092 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265063AbUAMTwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:52:23 -0500
Subject: Re: dmesg gives me request_module fail 2.6.1
From: Stian Jordet <liste@jordet.nu>
To: Eric Blade <eblade@blackmagik.dynup.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
References: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
Content-Type: text/plain
Message-Id: <1074023529.8295.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 20:52:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 13.01.2004 kl. 17.21 skrev Eric Blade:
> request_module: failed /sbin/modprobe -- net-pf-10. error = 65280

I get similar messages as well. net-pf-10 is ipv6, and the messages are
triggered when cron runs sendmail every ten minutes. Have no why, but
that's what's happening here.

Best regards,
Stian

