Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144272AbRA1WjC>; Sun, 28 Jan 2001 17:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144345AbRA1Wix>; Sun, 28 Jan 2001 17:38:53 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:16645 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S144272AbRA1Wis>; Sun, 28 Jan 2001 17:38:48 -0500
Date: Mon, 29 Jan 2001 09:38:54 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: raiserfs, 2.4.1preX and nfs
Message-ID: <20010129093854.C373@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm tempted to use raiserfs on a 45gig raid partition because I don't
want to grow old and die before it finishes fscking. The main hassle
is that that partition will be NFSed out and in the past there have
been mutterings of rfs hacing hassles with nfs. Have these been sorted?
Is there anything else I'd need to know about? A journalled fs would
be way nice to have and I need to make a decision between ext2 and rfs
asap.

any help would be greatly appreciated.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
