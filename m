Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281194AbRKLAci>; Sun, 11 Nov 2001 19:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKLAc3>; Sun, 11 Nov 2001 19:32:29 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:56504 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S281194AbRKLAcO>; Sun, 11 Nov 2001 19:32:14 -0500
Message-ID: <3BEF18BA.41D7F503@sibaz.com>
Date: Mon, 12 Nov 2001 00:32:59 +0000
From: Simon Bazley <sibaz@sibaz.com>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en-GB,en,en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HFS Filesystem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What information or documentation is there on HFS and writing linux applications what use resource forks and other mac quirkiness.
In particular how do I write an application that uses all the data availiable on macs (and hence HFS) but not commonly used.  Whats more if there is a method to access that data, what happens if I try using it on a non HFS file system.

I'm entertaining thoughts on tidying up some of the underlying code in netatalk if you're wondering why I'm asking all this.

Simon Bazley


