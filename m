Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUBTN1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUBTNZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:25:25 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37380 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261217AbUBTNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:20:00 -0500
Subject: Re: recommended "stable" compiler?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Bartos <spam99@2thebatcave.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <58930.192.168.1.12.1077278393.squirrel@mail.2thebatcave.com>
References: <58930.192.168.1.12.1077278393.squirrel@mail.2thebatcave.com>
Content-Type: text/plain
Message-Id: <1077283178.798.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 20 Feb 2004 14:19:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-20 at 12:59, Nick Bartos wrote:
> What is the recommended stable compiler for compiling the latest 2.4.x
> kernel?

I'm no kernel guru, but I have been compiling 2.5/2.6 kernels for a long
time with gcc 3.3 with no problems at all. I had problems with gcc 3.2
in the past, miscompiling the ymfpci driver.

