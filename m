Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbUCOX5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCOX5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:57:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:30173 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262857AbUCOXzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:55:20 -0500
Subject: Re: [PATCH] therm_adt7467 update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040313163334.3a3ad9c0@jack.colino.net>
References: <00e401c40776$2a37eca0$3cc8a8c0@epro.dom>
	 <1079045140.9745.295.camel@gaston>
	 <20040313163334.3a3ad9c0@jack.colino.net>
Content-Type: text/plain
Message-Id: <1079394567.2302.188.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 10:49:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, that's what I thought. 
> Would it help if I sent a simpler patch with the modifications to 
> therm_adt7467.c, Kconfig and Makefile, and specify to `bk mv` the file after
> applying the patch ?
> 
> Just in case, here it is. 
> Don't forget to rename drivers/macintosh/therm_adt7467.c to 
> therm_adt746x.c after :-)

Can you send that directly to Linus/Andrew ? I'm quite busy at
the moment.

Ben.


