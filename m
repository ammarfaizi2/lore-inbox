Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136718AbREAUsd>; Tue, 1 May 2001 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136717AbREAUsN>; Tue, 1 May 2001 16:48:13 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4356 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S136715AbREAUsB>; Tue, 1 May 2001 16:48:01 -0400
Date: Tue, 01 May 2001 22:48:02 +0200
From: Andreas Rogge <lu01@rogge.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Maximum files per Directory
Message-ID: <272800000.988750082@hades>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to create 100.000 (in words: one hundred thousand) Mailboxes 
with
cyrus-imapd i ran into problems.
At about 2^15 files the filesystem gave up, telling me that there cannot be
more files in a directory.

Is this a vfs-Issue or an ext2-issue?

Andreas Rogge <lu01@rogge.yi.org>
Available on IRCnet:#linux.de as Dyson
