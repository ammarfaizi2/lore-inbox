Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVJ2Q2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVJ2Q2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJ2Q2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 12:28:52 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:53402 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751216AbVJ2Q2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 12:28:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Date: Sat, 29 Oct 2005 11:28:47 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
References: <1130481024363@kroah.com> <200510290059.37135.dtor_core@ameritech.net> <20051029150451.GV27184@lug-owl.de>
In-Reply-To: <20051029150451.GV27184@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510291128.48203.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 10:04, Jan-Benedict Glaw wrote:
> Hi Dmitry!
> 
> On Sat, 2005-10-29 00:59:36 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> [...a patch I don't like]
> 

[ .. a patch that now I don't like ..]

The messages are only generated when someone explicitely enables LKKBD_DEBUG,
and if someone does enable it he surely can map the numeric values himself.
There is no need to clutter the code with insignificant details.

-- 
Dmitry
