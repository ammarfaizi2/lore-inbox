Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUEDBWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUEDBWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbUEDBWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:22:04 -0400
Received: from eth2612.sa.adsl.internode.on.net ([150.101.239.51]:47245 "EHLO
	jpearson") by vger.kernel.org with ESMTP id S262476AbUEDBV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:21:59 -0400
Date: Tue, 4 May 2004 10:52:32 +0930
From: John Pearson <jpearson@sa.pracom.com.au>
To: Thorild Selen <thorild@Update.UU.SE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange ext3 corruption problem on 2.6.x (good news, it seems)
Message-ID: <20040504012232.GA11429@sa.pracom.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed,
                                                                                
I was one of the people who posted earlier with this problem, and it
hasn't re-occurred since I upgraded to 2.6.5.
                                                                                
                                                                                
John Pearson
<previously posting as huiac at internode.on.net>

On Sun, May 02, 2004 at 11:39:41PM +0200, Thorild Selen wrote
> Brief followup to the ext3 on LVM on MD with SMP/HT brokenness:
> 
> It seems like recent jbd or DM locking fixes have solved this. I have
> tried stressing the fs hard for days to reproduce it with 2.6.6-rc2
> (otherwise using the same setup), but everything seems to keep working
> as it should.
> 
> 
> Thorild Selén
> Datorföreningen Update / Update Computer Club, Uppsala, SE
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> --__--__--
