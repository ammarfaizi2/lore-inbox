Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbTBGWGk>; Fri, 7 Feb 2003 17:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTBGWGj>; Fri, 7 Feb 2003 17:06:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:56464 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266721AbTBGWGj>;
	Fri, 7 Feb 2003 17:06:39 -0500
Date: Fri, 7 Feb 2003 14:15:49 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-Id: <20030207141549.6e69bc57.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302071338130.926-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0302061848360.851-200000@localhost.localdomain>
	<Pine.LNX.4.44.0302071338130.926-200000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2003 22:16:13.0374 (UTC) FILETIME=[868205E0:01C2CEF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gack, your whole tty layer didn't come up, or the device nodes aren't there.
Are you using devfs?
