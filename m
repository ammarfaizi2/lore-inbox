Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274830AbTGaRBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274831AbTGaRBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:01:30 -0400
Received: from smtp2.libero.it ([193.70.192.52]:35480 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S274830AbTGaRB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:01:29 -0400
Subject: Re: 2.6.0-test2, sensors and sysfs
From: Flameeyes <daps_mls@libero.it>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030731165056.GA3622@kroah.com>
References: <1059669362.23100.12.camel@laurelin>
	 <20030731165056.GA3622@kroah.com>
Content-Type: text/plain
Message-Id: <1059670884.23098.18.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 19:01:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 18:50, Greg KH wrote:
> What sensor drivers are you using in 2.4?  Are these drivers even
> present in 2.6?  Remember, a lot of them have not been ported yet.
The same, i2c-viapro and via686a, and they works well for mainboard, cpu
and system temperatures, and also for fans' rpms.
-- 
Flameeyes <dgp85@users.sf.net>

