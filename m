Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262254AbRENHCM>; Mon, 14 May 2001 03:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262257AbRENHCC>; Mon, 14 May 2001 03:02:02 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:3203 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S262254AbRENHB5>;
	Mon, 14 May 2001 03:01:57 -0400
Message-ID: <3AFF82DE.54CE69D2@mirai.cx>
Date: Mon, 14 May 2001 00:01:50 -0700
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Blesson Paul <blessonpaul@usa.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Inodes
In-Reply-To: <20010514065650.11112.qmail@nw176.netaddress.usa.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blesson Paul wrote:

> Hi
>                     This is an another doubt related to VFS. I want to know
> wheather all files are assigned their inode number at the mounting time itself
> or inodes are assigned to files upon accessing only

er..

inode numbers are assigned at file creation time.

cu

jjs

