Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSHQWJ7>; Sat, 17 Aug 2002 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSHQWJ7>; Sat, 17 Aug 2002 18:09:59 -0400
Received: from [143.166.83.88] ([143.166.83.88]:36618 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318756AbSHQWJ6>; Sat, 17 Aug 2002 18:09:58 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CB79@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: lm@bitmover.com, linux-kernel@vger.kernel.org
cc: davej@suse.de, torvalds@transmeta.com
Subject: RE: [BK PATCH 2.5.x] move asm-ia64/efi.h to linux/efi.h
Date: Sat, 17 Aug 2002 17:13:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1140152B77630-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is starting to be a FAQ so...
> 
> The way Linus wants to work with BK is to have a BK tree from which he
> can pull when he is ready to accept those changes.  You can set up a
> tree at your site if they haven't firewalled everything or you can set
> one up on bkbits.net.

I'd like to thank Larry for his assistance today.  Being behind a company
firewall with no outbound ssh port access, pushing stuff to bkbits.net
wasn't working.  He opened up a second ssh port (2222) on bkbits.net that
isn't generally blocked, and now I can push there.

BK_RSH="ssh -p 2222" bk push bk://project.bkbits.net/repository

Thanks!
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

