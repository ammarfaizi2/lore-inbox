Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSKJK0E>; Sun, 10 Nov 2002 05:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbSKJK0E>; Sun, 10 Nov 2002 05:26:04 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:25057 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264799AbSKJK0E>; Sun, 10 Nov 2002 05:26:04 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: no one in particular <lkml@krimedawg.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.46 (scheduler?)
Date: Sun, 10 Nov 2002 12:32:10 +0100
User-Agent: KMail/1.4.7
References: <Pine.LNX.4.44.0211091458160.484-100000@mcgruff.krimedawg.org>
In-Reply-To: <Pine.LNX.4.44.0211091458160.484-100000@mcgruff.krimedawg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211101232.12859.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trace; c0114380 <__wake_up+20/40>
> Trace; c0147b36 <pipe_write+1f6/240>
> Trace; c013e131 <vfs_write+c1/160>
> Trace; c013e3ea <sys_write+2a/40>
> Trace; c010897b <syscall_call+7/b>

I also got this once, but wasn't able to reproduce it.

Duncan.
