Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130432AbRCTQDa>; Tue, 20 Mar 2001 11:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRCTQDM>; Tue, 20 Mar 2001 11:03:12 -0500
Received: from [204.138.55.44] ([204.138.55.44]:40456 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130432AbRCTQDJ>;
	Tue, 20 Mar 2001 11:03:09 -0500
Date: Tue, 20 Mar 2001 11:01:27 -0500
From: Zach Brown <zab@zabbo.net>
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
Message-ID: <20010320110127.I4593@tetsuo.zabbo.net>
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com> <15030.54194.780246.320476@pizda.ninka.net> <3AB6D574.8C123AE9@chromium.com> <15030.54685.535763.403057@pizda.ninka.net> <3AB6D795.F06C1B18@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AB6D795.F06C1B18@chromium.com>; from fabio@chromium.com on Mon, Mar 19, 2001 at 08:07:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fantastic!
> 
> I was not aware of it, sorry... where can I find some doc?

There are some patches in the apache source rpms in
http://www.zabbo.net/phhttpd/ that shows how apache can connect to
another daemon and get its incoming connections sockets from it.

phhttpd itself is pretty hairy code (don't ask :)), but the apache
changes are pretty straight forward.

-- 
 zach
