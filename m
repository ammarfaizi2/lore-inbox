Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129090AbRBFErZ>; Mon, 5 Feb 2001 23:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRBFErP>; Mon, 5 Feb 2001 23:47:15 -0500
Received: from web10513.mail.yahoo.com ([216.136.172.145]:13062 "HELO
	web10513.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129090AbRBFErG>; Mon, 5 Feb 2001 23:47:06 -0500
Message-ID: <20010206044705.47936.qmail@web10513.mail.yahoo.com>
Date: Mon, 5 Feb 2001 20:47:05 -0800 (PST)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: walk the list of mount points inside a module
To: linux-kernel@vger.kernel.org
Cc: atai@atai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am writing a loadable module.  How can I get a
list of the current mounted volumns or mount points,
from inside a loadable module?   The symbol
"vfsmntlist" is not exported to modules.

Thanks for any info.

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
