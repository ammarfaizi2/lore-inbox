Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311634AbSCTPDv>; Wed, 20 Mar 2002 10:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311636AbSCTPDl>; Wed, 20 Mar 2002 10:03:41 -0500
Received: from [212.176.242.127] ([212.176.242.127]:21000 "EHLO
	penguin.aktivist.ru") by vger.kernel.org with ESMTP
	id <S311634AbSCTPDe>; Wed, 20 Mar 2002 10:03:34 -0500
Date: Wed, 20 Mar 2002 18:03:28 +0300
From: Wartan Hachaturow <wart@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Separate keymaps for separate vt's?
Message-ID: <20020320180328.A17898@penguin.aktivist.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

A couple of non-English users has asked me if there is an ability to
have different keymaps for different vt's in kernel.
It seems like kernel keeps just one translation table for all vt's.
I would be interested in patching console driver to keep separate tables
for separate vt's (that would allow me to include an ability to load
different keymaps in next release of Linux Console Tools). Perhaps there
are some ideas you can give me, or, perhaps, name a current console driver
maintainer for me to discuss this idea?

P.S. Please, Cc me on replies, since I'm not on the list.

-- 
TIA, Wartan.
echo "Your stdio isn't very std." 
		-- Larry Wall in Configure from the perl distribution

