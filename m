Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUFRUd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUFRUd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUFRUdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:33:55 -0400
Received: from web81301.mail.yahoo.com ([206.190.37.76]:15976 "HELO
	web81301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263295AbUFRUdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:33:42 -0400
Message-ID: <20040618203340.45436.qmail@web81301.mail.yahoo.com>
Date: Fri, 18 Jun 2004 13:33:40 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/11] New set of input patches
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The patches are against Vojtech's tree and should apply to -mm as well.
> 
> However, they won't apply onto Linus' tree and cause rejects in a good
> number of "interesting" files.

Well, I do not consider it tested enough to be ready for Linus yet :)
I am thinking about publushing my input-sysfs bk tree... Will there
be an interest in it or you just want a patch against the vanilla 2.6.7?
I can do a wholesale patch but splitting my changes from other stuff in
Vojtech's tree does not sound very appealing... 

--
Dmitry
