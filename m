Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261543AbTCOUQp>; Sat, 15 Mar 2003 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCOUQp>; Sat, 15 Mar 2003 15:16:45 -0500
Received: from comtv.ru ([217.10.32.4]:57259 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261543AbTCOUQh>;
	Sat, 15 Mar 2003 15:16:37 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove BKL from ext2's readdir
References: <m3vfyluedb.fsf@lexa.home.net>
	<20030315023614.3e28e67b.akpm@digeo.com>
	<20030315030322.792fa598.akpm@digeo.com>
	<m3wuj0fvls.fsf@lexa.home.net>
	<20030315121125.48294975.akpm@digeo.com>
	<m3smto4cjd.fsf@lexa.home.net>
	<20030315122432.1e3f8bd5.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 15 Mar 2003 23:19:17 +0300
In-Reply-To: <20030315122432.1e3f8bd5.akpm@digeo.com>
Message-ID: <m3hea42xiy.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> ah, OK.  How about this?

looks fine

