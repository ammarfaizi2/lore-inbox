Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285691AbRL3Xlh>; Sun, 30 Dec 2001 18:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbRL3Xl1>; Sun, 30 Dec 2001 18:41:27 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:50576 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S285691AbRL3XlO>; Sun, 30 Dec 2001 18:41:14 -0500
Date: Sun, 30 Dec 2001 23:43:33 +0000
From: Dave Jones <davej@suse.de>
To: reiserfs-dev@namesys.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Resyncing reiserfs changes to 2.5.
Message-ID: <20011230234333.F16788@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, reiserfs-dev@namesys.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
 The forward ported changes from 2.4 -> 2.5 for reiserfs
in my tree are nearly entirely hand merged by myself.

Whilst I've tested them with no problems, I'd prefer that
some of the reiserfs guys take a look at what I've done to
make sure I've not screwed up something obscure before I start
pushing this to Linus.

Jumbo patch as always is at...
  http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1-dj9.diff.bz2

regards,
Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
