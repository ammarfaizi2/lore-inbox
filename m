Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbRFMSzR>; Wed, 13 Jun 2001 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbRFMSzH>; Wed, 13 Jun 2001 14:55:07 -0400
Received: from port29.ds1-rdo.adsl.cybercity.dk ([212.242.196.94]:61543 "HELO
	xyzzy.adsl.dk") by vger.kernel.org with SMTP id <S263298AbRFMSyv>;
	Wed, 13 Jun 2001 14:54:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Has it been done: User Script File System?
In-Reply-To: <3B27A546.A64F8B00@lycosmail.com>
X-Home-Page: http://peter.makholm.net/
Xyzzy: Nothing happens!
From: Peter Makholm <peter@makholm.net>
Date: 13 Jun 2001 20:54:40 +0200
In-Reply-To: <3B27A546.A64F8B00@lycosmail.com> (russl@lycosmail.com's message of "Wed, 13 Jun 2001 17:40:30 +0000 (UTC)")
Message-ID: <878ziwtdlb.fsf@xyzzy.adsl.dk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

russl@lycosmail.com (Russ Lewis) writes:

> Is there any filesystem in Linux that uses user scripts/executables to
> implement the various function calls?  What I'm thinking of is something

It has been done before.

http://www.ibiblio.org/pub/Linux/ALPHA/userfs/userfs.lsm describes a
patch/kernel module for kernel 1.2.10, 1.3.13 and 2.0.30.

I vaguely remember that some more resen suggestion was to implement it
with the some usper-space nfs-deamon.

-- 
hash-bang-slash-bin-slash-bash
