Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbRFRHQo>; Mon, 18 Jun 2001 03:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263676AbRFRHQY>; Mon, 18 Jun 2001 03:16:24 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.121.49]:52208 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263674AbRFRHQR>; Mon, 18 Jun 2001 03:16:17 -0400
Message-ID: <3B2DABC1.E8819251@earthlink.net>
Date: Mon, 18 Jun 2001 02:20:33 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initrd question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Concerning the new way initrd works in 2.4...

I'm trying to get the system to the point where I can free the memory
used by the initrd.  I'm quite well aware of how to do this in a bash
script, but I want to know how to do the same from a C program.
Currently, something's keeping /dev/ram0 busy, so I know I'm doing
something wrong.

Kelledin

