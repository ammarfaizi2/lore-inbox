Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbTIDGNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbTIDGNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:13:04 -0400
Received: from f22.mail.ru ([194.67.57.55]:51721 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S264700AbTIDGND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:13:03 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Rusty Russell=?koi8-r?Q?=22=20?= 
	<rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_ALIAS for IRDA dongles
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 04 Sep 2003 10:12:50 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19unMQ-0001RE-00.arvidjaar-mail-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rather than hardcoded names in modprobe, modules can offer their own
> aliases (which are overridden by config files).

that's cool :)

what config files do you mean - Kconfig or modprobe.conf (or equiv.)?

-andrey

