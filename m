Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbTGUDfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 23:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269212AbTGUDfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 23:35:15 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:34210 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269211AbTGUDfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 23:35:13 -0400
Message-ID: <3F1B4695.5020507@cornell.edu>
Date: Sun, 20 Jul 2003 21:49:09 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles Lepple <clepple@ghz.cc>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 startup messages?
References: <20030720140035.GC20163@rdlg.net> <3F1AD2AA.9010603@cornell.edu> <yw1xbrvpuew9.fsf@users.sourceforge.net> <3F1B5312.9040502@ghz.cc>
In-Reply-To: <3F1B5312.9040502@ghz.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> couldn't you just set the 'install' action for "/dev/tts", etc. to
> '/bin/true'?

You'd have to do that for every single device program x.y.z might try to 
find in /dev. I, personally, get at least 25 warnings on boot.

