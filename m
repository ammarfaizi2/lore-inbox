Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276732AbRJHAws>; Sun, 7 Oct 2001 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276728AbRJHAw2>; Sun, 7 Oct 2001 20:52:28 -0400
Received: from zok.SGI.COM ([204.94.215.101]:42680 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276729AbRJHAwW>;
	Sun, 7 Oct 2001 20:52:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: System log is filling up with "VFS: Disk change detected on device sr(11,1)" messages 
In-Reply-To: Your message of "07 Oct 2001 09:33:21 MST."
             <1002472401.1660.45.camel@stomata.megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 10:52:40 +1000
Message-ID: <29404.1002502360@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Oct 2001 09:33:21 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>My /var/log/messages is getting consistently flooded with these
>messages:
>
>   VFS: Disk change detected on device sr(11,1)

Probably magicpath or similar utility that continually tries to detect
a CD.

