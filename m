Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWJXNsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWJXNsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWJXNsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:48:23 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:44698 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965139AbWJXNsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:48:22 -0400
Date: Tue, 24 Oct 2006 15:47:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Panagiotis Issaris <panagiotis@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PC speaker listed as input device
In-Reply-To: <20061024083821.GY26271@lug-owl.de>
Message-ID: <Pine.LNX.4.61.0610241546100.19278@yvahk01.tjqt.qr>
References: <ae7121c60610231132w4e8b13c8y30865682e815b00c@mail.gmail.com>
 <20061024083821.GY26271@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The Input subsystem also covers simple beeps, because real keyboards
>beep.  So it was only straight-forward to also put the PC speaker into

"What is real?" -from Matrix

That said, older keyboards, such as SUN4, do indeed beep themselves. In fact,
it's just a matter where the beeper is installed, even on x86, you can see the
history of it, because the IO port for beeps is the same as for keyboard leds.


	-`J'
-- 
