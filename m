Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTEOTGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTEOTGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:06:19 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:17563 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264169AbTEOTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:06:19 -0400
Message-Id: <200305151917.h4FJHbGi014157@locutus.cmf.nrl.navy.mil>
To: Greg KH <greg@kroah.com>
cc: duncan.sands@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Thu, 15 May 2003 12:09:23 PDT."
             <20030515190922.GA10161@kroah.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 15 May 2003 15:17:37 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030515190922.GA10161@kroah.com>,Greg KH writes:
>Thanks, didn't know they could be removed.  The speedtch author told me
>a while ago that the fops didn't protect it...

i cant see why it wouldn't but i really dont have the hardware to double
check this statement.
