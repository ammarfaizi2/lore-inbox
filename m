Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVJJLWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVJJLWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVJJLWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:22:35 -0400
Received: from web30309.mail.mud.yahoo.com ([68.142.200.102]:47966 "HELO
	web30309.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750750AbVJJLWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:22:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jy5zuB4WdsWAcI5EYmfZv2TeUtPchiZNZuL0b/V8oSYuO3F1L+0HLQWVWDi/xouSlivGcv0F0AVWorrG8R6NBhg39JLpejFgsBakPjSSl0PjW/j23MBtDwaT1oAVtFk2tbuu37EZrOFRgEL6xD1lHKO4fvnVq3EchXda9vALrf8=  ;
Message-ID: <20051010112233.6739.qmail@web30309.mail.mud.yahoo.com>
Date: Mon, 10 Oct 2005 04:22:33 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051010105423.GA11982@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No. I'm running each disk with its own XFS partition.

Unfortunately I'm not in the position to experiment
much on this system.

Which tool can I use to stress all 12 disks reading
many many files in parallel?

Thanks

> Nice.  Have you tried Software RAID5 on top of that?
> I would be very interested to know how software
> RAID5
> goes relative to the 3Ware hardware.
> 


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free.
http://music.yahoo.com/unlimited/
