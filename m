Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUFLJP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUFLJP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 05:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbUFLJP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 05:15:59 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:16075 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S264693AbUFLJP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 05:15:57 -0400
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 12 Jun 2004 10:15:55 +0100
MIME-Version: 1.0
Subject: Re: Typo in fs/smbfs/file.c
Message-ID: <40CAD7DB.3188.17917F3D@localhost>
X-mailer: Pegasus Mail for Windows (4.21a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported this sometime back, and it appears it's not so much of a 
typo, but GCC allows both in some cases - but not _my_ GCC.

http://lkml.org/lkml/2004/3/14/53

I have to change to upper case 'Z' every new build to get it to build 
clean.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

