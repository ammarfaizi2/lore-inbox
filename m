Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbQKIWq3>; Thu, 9 Nov 2000 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQKIWqT>; Thu, 9 Nov 2000 17:46:19 -0500
Received: from main.cyclades.com ([209.128.87.2]:43534 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129280AbQKIWqK>;
	Thu, 9 Nov 2000 17:46:10 -0500
Date: Thu, 9 Nov 2000 14:46:09 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Patch generation
Message-ID: <Pine.LNX.4.10.10011091442570.26422-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Where in the src tree can I find (or what is) the command to generate a
patch file from two Linux kernel src trees, one being the original and the
other being the newly changed one??

I've tried 'diff -ruN', but that does diff's on several files that could
stay out of the comparison (such as the files in include/config, .files,
etc.).

Thanks in advance for your help.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
