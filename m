Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbRDQXph>; Tue, 17 Apr 2001 19:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132863AbRDQXpb>; Tue, 17 Apr 2001 19:45:31 -0400
Received: from cc885639-a.flushing1.mi.home.com ([24.182.96.34]:31248 "HELO
	caesar.lynix.com") by vger.kernel.org with SMTP id <S132853AbRDQXpW>;
	Tue, 17 Apr 2001 19:45:22 -0400
Date: Tue, 17 Apr 2001 19:45:58 +0000
From: Subba Rao <subba9@home.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Adaptec 2940 and Linux 2.2.19
Message-ID: <20010417194558.A10678@home.com>
Reply-To: Subba Rao <subba9@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The kernel configuration menu items have been changing quite a bit. So, I
apologize for asking a trivial question in this forum.

I am trying to configure and install linux kernel 2.2.19. This system has
a Adaptec 2940 SCSI adapter. I have enabled SCSI support kernel configuration
menu and also have selected all the Adaptec low-level drivers. They include
(actually what is offered), AHA152X/2825, AHA1542 and AHA1740. When the kernel
is booting up it still does not find the AHA2940 adapter.

What (other) options should I configure to make Linux 2.2.19 find the adapter?

Thank you in advance for any help.
-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID 27FC9217
