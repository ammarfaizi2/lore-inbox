Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUHSN4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUHSN4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUHSN4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:56:38 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:900 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266189AbUHSN4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:56:14 -0400
Date: Thu, 19 Aug 2004 15:56:14 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040819135614.GA12634@ucw.cz>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz> <4124AD46.nail80H216HKB@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4124AD46.nail80H216HKB@burner>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >Hmmm, it seems that the matter is so complicated that even you don't know what's
> >going on ;-)  The latest issue of Debian Weekly News explicitly mentions that
> >cdrecord has to go to non-free unless the license additions get changed.
> 
> Maybe your problem is that you are not involved with the discussion?
> From the last discussions, I can tell that Debian has no problems with what's 
> going to become cdrtools-2.01-final.

Yes, from the last discussions. But you cannot deny that Debian initially
considered moving cdrecord to non-free, which was the point of the post you
replied to.

> I explain why e.g. SuSE is non-cooperative. This is different from what you 
> write.

You explain that SuSE is non-cooperative, because they distribute crippled
cdrecord, but you fail to explain what crippledness do you have in mind.

Also, if you put away your flamethrower and just politely asked SUSE to add
a message like `this version has been modified by SUSE, so please send your
bug reports to support@suse.com instead of the original author', the whole
issue would be probably already settled a long time ago.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Don't forget to save the Earth! We don't have any backups!
