Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWHNDYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWHNDYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 23:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWHNDYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 23:24:03 -0400
Received: from smtpout.mac.com ([17.250.248.174]:32470 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751829AbWHNDYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 23:24:02 -0400
In-Reply-To: <62b0912f0608131221n1657905p327b7ece6d06d20d@mail.gmail.com>
References: <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com> <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com> <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com> <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com> <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com> <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com> <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com> <20060812163834.GA11497@thunk.org> <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com> <20060812214719.GA19156@thunk.org> <62b0912f0608131221n1657905p327b7ece6d06d20d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <076B9008-E1BA-4B80-9692-56E794AE114D@mac.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: ext3 corruption
Date: Sun, 13 Aug 2006 23:23:53 -0400
To: Molle Bestefich <molle.bestefich@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2006, at 15:21:24, Molle Bestefich wrote:
> Theodore Tso wrote:
>> (This is open source, which means if people who have the bad  
>> manners to kvetch that volunteers have done all of this free work  
>> for them haven't done $FOO will be gently reminded that patches to  
>> implement $FOO are always welcome.  :-)
>
> OTOH, the open source community rigorously PR Linux as an  
> alternative to Windows.

Some people do; some people believe it's still not ready (for the  
desktop environment where Windows currently has majority  
marketshare).  I run a fileserver for my parents and wouldn't use  
anything other than Linux/OpenLDAP/Samba/device-mapper/mdadm on fully  
open-spec hardware, but I wouldn't expect them to do anything other  
than call me when it breaks and maybe follow a few specific  
instructions for getting it network-accessible again via server- 
management chip.  This is all really easy for _me_ to manage with  
Linux on good server hardware, but that's not something I'd think a  
non-admin could handle on their own.  And for 3D graphics, GUI  
programs, etc, IMHO Linux is still miles from being where it needs to  
be to really compete.

> While the above attitude is fine by me, you're going to have to  
> expect to see some sad faces from Windows users when they create a  
> filesystem on a loop device and don't realize that the loop driver  
> destroys journaling expectancies and results in all their photos  
> and home videos going down the drain, all because nobody  
> implemented a simple "warning!" message in the software.

This is really what distros are expected to do (at least in the  
current environment).  The major development groups don't have the  
financial and legal backing to be able to certify reliability and  
support for *any* user, let alone your average Joe User who's used to  
Windows and *clicky*-*clicky*-ing his way around the UI.  Eventually  
there will be enough vendors selling Linux-based systems that the UI- 
polish patches will be developed as rapidly as the fundamental  
underlying infrastructure, but we're not there yet.  Ubuntu and such  
are paving the way for future even-better-than-mac vertical UI  
integration but we have a lot of UI infrastructure (especially 3d  
support in X) that needs fixing first.  IMHO Linux is still very much  
for hobbyists, server administrators, and other people who have at  
least a modicum of computer problem-solving skills.

> (Or whatever.  Lots of similar examples exist to show you that the  
> "no warranty: you use our software, you learn to hack it to do what  
> you want yourself or it's your own fault" argument is fallacious.)

That kind of warranty is a hobbyist-type warranty.  Some companies  
invest money to build upon that and provide server-admin-type or end- 
user-type warranties, but such support costs money and time which  
most upstream developers don't have.

Cheers,
Kyle Moffett

