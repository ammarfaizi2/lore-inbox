Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271666AbRHQOun>; Fri, 17 Aug 2001 10:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271650AbRHQOud>; Fri, 17 Aug 2001 10:50:33 -0400
Received: from mail.internet-factory.de ([195.122.142.5]:6798 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S271666AbRHQOuX>; Fri, 17 Aug 2001 10:50:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: Encrypted Swap
Date: Fri, 17 Aug 2001 16:50:36 +0200
Organization: Internet Factory AG
Message-ID: <3B7D2F3C.A4687E25@internet-factory.de>
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain> <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 998059836 1407 195.122.142.158 (17 Aug 2001 14:50:36 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 17 Aug 2001 14:50:36 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac3 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Mack proclaimed:
> is running.  If the system is physically compromised, there is little way
> I can think of to take root without having to at least reboot the
> computer, thus destroying the unencrypted contents of RAM.

This is a myth. RAM survives rebooting, even after a quick power cycle
most cells will probably still be ok. And with todays memory sizes, it
would take a noticable amount of time to initialize all of it to a given
value, so most systems don't do it (just testing some bytes of every
megabyte instead).

Holger
