Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSFCMdb>; Mon, 3 Jun 2002 08:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSFCMda>; Mon, 3 Jun 2002 08:33:30 -0400
Received: from [213.196.40.44] ([213.196.40.44]:64721 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S314241AbSFCMd3>;
	Mon, 3 Jun 2002 08:33:29 -0400
Date: Mon, 3 Jun 2002 14:07:54 +0200 (CEST)
From: <bvermeul@devel.blackstar.nl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.19/20] KDE panel (kicker) not starting up
Message-ID: <Pine.LNX.4.33.0206031403190.24283-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The KDE panel (kicker) from KDE 3.0 (RedHat 7.3 issue) refuses to start
up. I get a SIGPIPE in DCOP, and a SIGSEGV in kicker.
This looks like something changed in regards to permissions, 'cause when I 
start KDE as root, it does work.

Does anyone know what's happening?

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

