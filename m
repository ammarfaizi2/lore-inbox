Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbTBKKzA>; Tue, 11 Feb 2003 05:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTBKKxP>; Tue, 11 Feb 2003 05:53:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12292 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267575AbTBKKvy>;
	Tue, 11 Feb 2003 05:51:54 -0500
Date: Mon, 10 Feb 2003 20:23:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: devnetfs <devnetfs@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling kernel with debug and optimization
Message-ID: <20030210192324.GA154@elf.ucw.cz>
References: <20030210111151.31800.qmail@web20418.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210111151.31800.qmail@web20418.mail.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Does compiling with -g option degrade performance? IMO it should NOT.
> 
> If that's true, then why dont we compile kernels with both -g and -O2
> always? 

Build with -g takes *a lot* of diskspace, like 1Gig.
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
