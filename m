Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318758AbSHQVAL>; Sat, 17 Aug 2002 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318764AbSHQVAL>; Sat, 17 Aug 2002 17:00:11 -0400
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:15120 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318758AbSHQVAI>; Sat, 17 Aug 2002 17:00:08 -0400
X-Server-Uuid: 82a6c0aa-b49f-4ad3-8d2c-07dae6b04e32
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CB78@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: bunk@fs.tum.de, marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: RE: [BK PATCH 2.4.x] move asm-ia64/efi.h to linux/efi.h (was
 RE: Lin ux 2.4.20-pre3)
Date: Sat, 17 Aug 2002 16:04:02 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 114065C81479743-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I sure hope so.  Here's the patch set for 2.4.x which fixes 
> the NULL_GUID
> bug, moves efi.h from include/asm-ia64 to include/linux, and fixes
> efi_guid_unparse.

Now available, please bk pull http://mdomsch.bkbits.net/linux-2.4-gpt

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

