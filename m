Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292337AbSBYVNs>; Mon, 25 Feb 2002 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292341AbSBYVNi>; Mon, 25 Feb 2002 16:13:38 -0500
Received: from c9mailgw.prontomail.com ([216.163.188.207]:18959 "EHLO
	C9Mailgw07.amadis.com") by vger.kernel.org with ESMTP
	id <S292337AbSBYVNY>; Mon, 25 Feb 2002 16:13:24 -0500
Message-ID: <3C7AA8F1.3F93EFB4@starband.net>
Date: Mon, 25 Feb 2002 16:13:21 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Quinlan <quinlan@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 - Fixed?
In-Reply-To: <Pine.LNX.4.21.0202251537080.31438-100000@freak.distro.conectiva> <Pine.LNX.4.21.0202251556140.31438-100000@freak.distro.conectiva> <6ypu2twaz3.fsf@sodium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like its fixed.

[root@war root]# cd /usr/src/linux-2.4.18
[root@war linux-2.4.18]# patch -p1 < ../linux-2.4.18
linux-2.4.18          linux-2.4.18.tar.bz2
[root@war linux-2.4.18]# patch -p1 < ../patch-2.4.18-rc4
patching file CREDITS
Reversed (or previously applied) patch detected!  Assume -R? [n]


