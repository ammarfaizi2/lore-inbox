Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312757AbSDBPjo>; Tue, 2 Apr 2002 10:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312792AbSDBPje>; Tue, 2 Apr 2002 10:39:34 -0500
Received: from air-2.osdl.org ([65.201.151.6]:9476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312757AbSDBPjV>;
	Tue, 2 Apr 2002 10:39:21 -0500
Date: Tue, 2 Apr 2002 07:39:20 -0800
From: Bob Miller <rem@osdl.org>
To: Louis Adamich <ladamich@cox.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 keyboard problem
Message-ID: <20020402073920.A26631@build.pdx.osdl.net>
In-Reply-To: <3CA99976.8060505@cox.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 06:43:50AM -0500, Louis Adamich wrote:
> I'm having a problem getting my keyboard to work on 2.5.7.  2.5.5 
> compiled and works correctly for me.  2.5.7 compiles with no errors as 
> well as all modules compiling with no errors.  No matter what 
> combination of config params I try I can't get the system to recognize 
> keystrokes.  If I boot to level 3 I just see nothing when I type.  If I 
> boot into X I can move the mouse around until I press a key and then the 
> mouse freezes.  The machine is still running as I can telnet into it 
> from another machine.  I also tried downloading and applying the dj 
> patch.  Same symptoms.
> 
> Machine is an Althon XP 1800+, soyo dragon plus motherboard, ATI 128 
> video card, 40 gig ide hard drive.
> 
> What info do I need to post to get some help debugging this thing?
> 
> Thanks,
> 
> Louis Adamich
> 

Look at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101751890301820&w=2

This should get you pointed in the right direction.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
