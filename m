Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281966AbRLASF5>; Sat, 1 Dec 2001 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284174AbRLASFs>; Sat, 1 Dec 2001 13:05:48 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:3332 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S281966AbRLASFa>; Sat, 1 Dec 2001 13:05:30 -0500
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path changes
In-Reply-To: <Pine.LNX.4.33.0112011942340.14914-100000@netfinity.realnet.co.sz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 Dec 2001 03:05:10 +0900
In-Reply-To: <Pine.LNX.4.33.0112011942340.14914-100000@netfinity.realnet.co.sz>
Message-ID: <871yierf3d.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linux.realnet.co.sz> writes:

> On Sun, 2 Dec 2001, OGAWA Hirofumi wrote:
> > In all failed cases, this message will be outputted. I think I shouldn't do
> > so. (or remove this message.)
> 
> I found all sorts of interesting things in my little adventure...
> Heres an interesting one;

Do you want to see the following message, even when not using nls?

FAT: freeing iocharset=<NULL>
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
