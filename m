Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUHaM5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUHaM5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUHaM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:57:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58503 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268329AbUHaMxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:53:42 -0400
Date: Tue, 31 Aug 2004 08:53:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeba Anandhan A <jeba_career@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Programming
In-Reply-To: <20040831124138.35309.qmail@web50607.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0408310851130.24913@chaos>
References: <20040831124138.35309.qmail@web50607.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004, Jeba Anandhan A wrote:

> i like to write filesystem programming .
> how to start ?.
>
> i am studying filesystem concepts and filesystem
> objects.
> how to access the superblock info of mounted
> filesystem .
>

Just read the raw device. You can get the source-code
of all the ext2/3 untilities off the net. This will
show everything you need to know (except how to put
the file-system back together after your first mistake)(^.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

