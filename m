Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSDTRNP>; Sat, 20 Apr 2002 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314660AbSDTRNO>; Sat, 20 Apr 2002 13:13:14 -0400
Received: from relay1.pair.com ([209.68.1.20]:28684 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S314657AbSDTRNN>;
	Sat, 20 Apr 2002 13:13:13 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CC1A1EF.AF524412@kegel.com>
Date: Sat, 20 Apr 2002 10:14:23 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: CONFIG_RAMFS in 2.4.19-pre7-ac2 ???
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Roy wrote:
> After upgrading to 2.4.19-pre7-ac2, I can't get CONFIG_RAMFS

Gee, I hope CONFIG_RAMFS isn't going away.  I need it to
do loopback mounts of cramfs on an embedded system that
uses tmpfs as its main filesystem.  (tmpfs doesn't support
loopback mounts.)
- Dan
