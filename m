Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRCCSpH>; Sat, 3 Mar 2001 13:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129660AbRCCSo5>; Sat, 3 Mar 2001 13:44:57 -0500
Received: from webmailstation.com ([208.231.7.196]:23320 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S129657AbRCCSoo>; Sat, 3 Mar 2001 13:44:44 -0500
Date: Sat, 3 Mar 2001 13:37:42 -0500 (EST)
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: Q: How to get physical memory size from user space without proc fs
Message-ID: <Pine.LNX.4.10.10103031332480.11778-100000@mx.webmailstation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

actually the question is in subj.
Problem is that there is a program which needs to know physical memory
size. This information is used to justify memory consumption as after some
swapping performance is drops dramatically, and it is better to finish.

I know that this is not the best idea, but it is assumed that this program
is the only one running on the machine.

I do not want to use proc as some people can just do not mount it.

Any comments, suggestions?

Thanks in advance.

Denis Perchine.



