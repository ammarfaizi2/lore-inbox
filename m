Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319042AbSIDDrk>; Tue, 3 Sep 2002 23:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319044AbSIDDrk>; Tue, 3 Sep 2002 23:47:40 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24847
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319042AbSIDDrj>; Tue, 3 Sep 2002 23:47:39 -0400
Subject: Re: 2.5 Problem Report Status
From: Robert Love <rml@tech9.net>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209032223110.2336-100000@dad.molina>
References: <Pine.LNX.4.44.0209032223110.2336-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Sep 2002 23:52:20 -0400
Message-Id: <1031111540.979.3283.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 23:26, Thomas Molina wrote:

>    Problem Title                  Status                Discussion
>    schedule() with irqs disabled! open                  03 Sep 2002

A "fix" is in Linus's bitkeeper tree now and will appear in 2.5.34... so
now it is closed.

Note this was never a problem - it was an informative debugging message
that unfortunately happens much more often than anticipated.

	Robert Love

