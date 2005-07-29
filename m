Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVG2UnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVG2UnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVG2Ukg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:40:36 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:25247 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262800AbVG2Uia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:38:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of pages in PBE list
Date: Fri, 29 Jul 2005 22:43:27 +0200
User-Agent: KMail/1.8.1
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <42EA87A0.908@stud.feec.vutbr.cz>
In-Reply-To: <42EA87A0.908@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507292243.28276.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> The function calc_nr uses an iterative algorithm to calculate the number 
> of pages needed for the image and the pagedir. Exactly the same result 
> can be obtained with a one-line expression.

Could you please post the proof?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
