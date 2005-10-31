Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVJaHCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVJaHCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVJaHCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:02:18 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:5513 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932273AbVJaHCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:02:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Date: Mon, 31 Oct 2005 02:02:15 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
References: <1130481024363@kroah.com> <200510291128.48203.dtor_core@ameritech.net> <20051029185321.GY27184@lug-owl.de>
In-Reply-To: <20051029185321.GY27184@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310202.16104.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 13:53, Jan-Benedict Glaw wrote:
> Here's a revised version of the patch, making the function and it's
> data static, as well as stuffing them into #ifdef DEBUG.
> 

If you could resend the patch with Signed-off-by line I would add it
to my input tree.

Thanks!

-- 
Dmitry
