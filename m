Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313632AbSDHOV2>; Mon, 8 Apr 2002 10:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313633AbSDHOV1>; Mon, 8 Apr 2002 10:21:27 -0400
Received: from gumby.it.wmich.edu ([141.218.23.21]:25472 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S313632AbSDHOV0>; Mon, 8 Apr 2002 10:21:26 -0400
Subject: Re: Make swsusp actually work
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020408102508.GA2494@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 10:21:17 -0400
Message-Id: <1018275683.10462.134.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the documentation suggests that you do not need to specify resume= .  Is
this only true if you have the sysvinit patch in use?  Is swapon -a
simply a matter of making it the first init script executed by init?

