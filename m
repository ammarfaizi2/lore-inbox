Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUDPBwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDPBwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:52:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:26504 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261156AbUDPBwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:52:10 -0400
Subject: Re: radeonfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timothy Miller <miller@techsource.com>
Cc: Felix von Leitner <felix-kernel@fefe.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <407EFB08.6050307@techsource.com>
References: <20040415202523.GA17316@codeblau.de>
	 <407EFB08.6050307@techsource.com>
Content-Type: text/plain
Message-Id: <1082079792.2499.229.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 11:43:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> What annoys me most about the Radeon driver is the off-by-one error in 
> the bmove routine.  Whenever text is copied to the right or down, it 
> gets positioned incorrectly.  I posted the fix, but no one paid attention.

Mayb it was just "missed" in the flow of hundreds of mails that go
through this list. Can you re-sent it to me, and also precise which
kernel version it applies to ?

Ben.


