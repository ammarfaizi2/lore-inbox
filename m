Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTEFCpM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTEFCpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:45:11 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49423
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262271AbTEFCpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:45:11 -0400
Date: Mon, 5 May 2003 19:57:35 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030506025735.GE8350@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May  5 15:32:10 fileserver kernel: lockd: can't encode arguments: 5
May  5 15:33:08 fileserver last message repeated 18 times
May  5 15:34:07 fileserver last message repeated 27 times
May  5 15:35:07 fileserver last message repeated 23 times
May  5 15:36:08 fileserver last message repeated 10 times
May  5 15:37:09 fileserver last message repeated 22 times
May  5 15:37:34 fileserver last message repeated 9 times

I get this on a pii 233 with reiserfs 112GB (120GB) drive.

The actual kernel used was vmlinuz-2.4.21-rc1-rmap15g.

vmlinuz-2.4.20-rmap15e is working without producing these errors.  (I'm
still testing now...)

Thanks,

Mike
