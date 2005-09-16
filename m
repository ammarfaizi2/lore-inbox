Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVIPVRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVIPVRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVIPVRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:17:19 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:3537
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751296AbVIPVRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:17:19 -0400
Subject: Re: R52 hdaps support?
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <432B34D6.6010904@gmail.com>
References: <432B34D6.6010904@gmail.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 15:17:28 -0600
Message-Id: <1126905449.5609.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 17:10 -0400, Keenan Pepper wrote:
> I recently splurged on a new ThinkPad R52 (because it was one of the few laptops 
> in the store with /all/ linux-supported hardware), but the 2.6.14-rc1 kernel I 
> just compiled says "hdaps: supported laptop not found".
> 
> Looking at the source I notice there's a whitelist of models that goes up to 
> R51... How badly could it break if I just went ahead and added R52? Should it be 
> "NORMAL" or "INVERT"?
> 
> Keenan Pepper

Hi Keenan,

	We don't have the X42 nor the R52 in the list of supported laptops.
Please send an email to hdaps-devel@lists.sf.net so that we can do
something about adding your laptop to the dmi list.

Additionally, the X41 should be in the list of supported laptops
(Kconfig)

Thanks,

.Alejandro

