Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVBQRCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVBQRCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVBQRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:02:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5134 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262308AbVBQRCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:02:16 -0500
Date: Thu, 17 Feb 2005 18:02:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Paolo Ornati <ornati@fastwebnet.it>, bruno.virlet@gmail.com,
       linux-kernel@vger.kernel.org
Subject: spam mails with the same Message-ID
Message-ID: <20050217170211.GA1772@stusta.de>
References: <4213AB2B.2050604@giesskaennchen.de> <20050217154250.110f4615@localhost> <20050217161048.20daf6cd@localhost> <200502171026.55766.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502171026.55766.kernel-stuff@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 10:26:55AM -0500, Parag Warudkar wrote:
> On Thursday 17 February 2005 10:10 am, Paolo Ornati wrote:
> > > ÄúºÃ£º
> > >     ÎÒÒÑ_­ÊÕµ_ÄúµÄÀ_ÐÅ
> >
> > and... what does this means?
> SPAM. This looks to me like a new way of spamming though, replying to valid 
> mailing list messages. (I too received couple of these in reply to my 
> messages.)

The most interesting fact seems to be that these spam messages have the 
same message ID as the original Mails.

If you run a program that automatically discards duplicate mails and the 
spam message reaches you faster than the original email through 
linux-kernel (which seems to often happen with these mails), the 
original email will be discarded. 

I don't know whether these are known attacks, but the automatic 
discarding of duplicated emails offers attackers nice opportunities if 
they know a message ID (as with these emails) or can guess the
message ID (since many MUAs have predictable message IDs, an attacker C
could use this to suppress a message from person A to person B by 
sending an email with the message ID to person B bevor person B gets 
the email from person A).

> Parag

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

