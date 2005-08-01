Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVHAFLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVHAFLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 01:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVHAFLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 01:11:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41634 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261263AbVHAFK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 01:10:59 -0400
Subject: Re: IBM HDAPS, I need a tip.
From: Lee Revell <rlrevell@joe-job.com>
To: abonilla@linuxwireless.org
Cc: linux-kernel@vger.kernel.org,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, Dave Hansen <dave@sr71.net>
In-Reply-To: <1122872189.5299.1.camel@localhost.localdomain>
References: <1122861215.11148.26.camel@localhost.localdomain>
	 <1122872189.5299.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 01:10:57 -0400
Message-Id: <1122873057.15825.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 22:56 -0600, Alejandro Bonilla Beeche wrote:
> Second Try... ;-)
> 
> Anyone? 

You're obviously getting different values because "moving the laptop
left to right" will produce a different acceleration every time.

So in order to calibrate it you need a readily available source of
constant acceleration, preferably with a known value.

Hint: -9.8 m/sec^2.

Lee



