Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269452AbUI3TwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269452AbUI3TwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbUI3TwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:52:06 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:30830 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269452AbUI3TwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:52:03 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1096569273.19487.46.camel@localhost.localdomain>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
	 <1096571398.1938.112.camel@deimos.microgate.com>
	 <1096569273.19487.46.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1096573912.1938.136.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 14:51:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 13:34, Alan Cox wrote:
> This is strictly forbidden and always has been. I've no
> plan to touch that restriction merely to re-educate 
> any offender

Any offender in this case is most serial drivers,
including the 8520/serial driver in current 2.6

-- 
Paul Fulghum
paulkf@microgate.com

