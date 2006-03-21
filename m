Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWCUT5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWCUT5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWCUT5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:57:30 -0500
Received: from mxsf41.cluster1.charter.net ([209.225.28.173]:10427 "EHLO
	mxsf41.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965104AbWCUT53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:57:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17440.23205.489606.464029@smtp.charter.net>
Date: Tue, 21 Mar 2006 14:57:25 -0500
From: "John Stoffel" <john@stoffel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <442050C8.1020200@zytor.com>
References: <1142890822.5007.18.camel@localhost.localdomain>
	<20060320134533.febb0155.rdunlap@xenotime.net>
	<dvn835$lvo$1@terminus.zytor.com>
	<Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
	<44203B86.5000003@zytor.com>
	<Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr>
	<442040CB.2020201@zytor.com>
	<Pine.LNX.4.61.0603211911090.2314@yvahk01.tjqt.qr>
	<44204BD9.1090103@zytor.com>
	<Pine.LNX.4.61.0603212005250.6840@yvahk01.tjqt.qr>
	<442050C8.1020200@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "H" == H Peter Anvin <hpa@zytor.com> writes:

H> It probably depends on how picky you want to be.  As far as I know,
H> even NT will recognize a character device name without leaving
H> \DEV\, even though \DEV\ has been the "official" device prefix
H> since DOS 2.0.

H> Probably it would be worth trying to create "aux.h" under XP and
H> see what happens.  Unfortunately I don't have a 'doze system handy
H> at the moment.

Unfortunately I do.  The desktop won't let me create a file named
'aux' or 'aux.h' at all.  I tried fooling it with 'auxx' and then
renaming it it 'aux' but it won't let me using the mouse stuff.

Still wouldn't let me create that name from the 'cmd' shell either.  

John
