Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTCDVrb>; Tue, 4 Mar 2003 16:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTCDVrb>; Tue, 4 Mar 2003 16:47:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261495AbTCDVra>;
	Tue, 4 Mar 2003 16:47:30 -0500
Subject: Re: 2.5.63-mm2
From: Mark Wong <markw@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030302180959.3c9c437a.akpm@digeo.com>
References: <20030302180959.3c9c437a.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Mar 2003 13:57:57 -0800
Message-Id: <1046815078.12931.79.camel@ibm-b>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears something is conflicting with the old Adapatec AIC7xxx.  My
system halts when it attempts to probe the devices (I think it's that.) 
So I started using the new AIC7xxx driver and all is well.  I don't see
any messages to the console that points to any causes.  Is there
someplace I can look for a clue to the problem?

I actually didn't realize I was using the old driver and have no qualms
about not using it, but if it'll help someone else, I can help gather
information.

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x 32 (office)
(503)-626-2436      (fax)
http://www.osdl.org/archive/markw/

