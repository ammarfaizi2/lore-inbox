Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSKDQWA>; Mon, 4 Nov 2002 11:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264727AbSKDQWA>; Mon, 4 Nov 2002 11:22:00 -0500
Received: from mx2.fcservices.com ([64.245.25.141]:11539 "HELO
	mx2.fcservices.com") by vger.kernel.org with SMTP
	id <S264724AbSKDQV7>; Mon, 4 Nov 2002 11:21:59 -0500
Subject: Re: Early Christmas
From: Disconnect <lkml@sigkill.net>
To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021101162027.2580A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021101162027.2580A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Nov 2002 11:27:19 -0500
Message-Id: <1036427240.8890.6.camel@sparky>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 16:21, Richard B. Johnson wrote:
> 
>      Let me get this out before Christmas (with apologies
>      for being off-topic)


Thats cute.. unfortunately, that's what just happened to my linux
server.  (It went sky high, 400-odd entries in /lost+found after a
corrupted ext3 superblock.  Oh, and most of /etc (at least) was
corrupted with binary garbage.  Linux tends to get annoyed when
/etc/group is nothing but 8bit noise...)

If I can reproduce it on something slightly less 'weird' (read: heavily
patched and completely untested) than the Gentoo kernels I'll post bug
reports.  But in the meantime, recovery continues ... :(


