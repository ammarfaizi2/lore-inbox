Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTHLJVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTHLJVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:21:14 -0400
Received: from f20.mail.ru ([194.67.57.52]:48399 "EHLO f20.mail.ru")
	by vger.kernel.org with ESMTP id S262872AbTHLJVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:21:13 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=James Simmons=?koi8-r?Q?=22=20?= 
	<jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: mouse and keyboard by default if not embedded
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 12 Aug 2003 13:21:13 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mVL7-000EMp-00.arvidjaar-mail-ru@f20.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> kYes it is fine. That is a PS/2 aux emulator. It turns non PS/2 mice into 
> PS/2 mice. Personally I rather have people use the /dev/input/eventX 
> interface. That PS/2 hack will go away in the future. 

does XFree support event?

also there dual boot 2.4/2.6 systems where you have single XFree config
and single gpm config ... although these will have problems with
non-imps2 mice anyway.

Anyone does dual boot with non-imps2 mouse BTW? I am interested in how
people handle it.

TIA

-andrey


