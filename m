Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136639AbREAPnc>; Tue, 1 May 2001 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136637AbREAPnW>; Tue, 1 May 2001 11:43:22 -0400
Received: from pc-62-30-76-3-az.blueyonder.co.uk ([62.30.76.3]:5892 "EHLO
	mnemosyne.j-harris.dircon.co.uk") by vger.kernel.org with ESMTP
	id <S136635AbREAPnN>; Tue, 1 May 2001 11:43:13 -0400
Message-ID: <3AEED9A8.56205EBE@uwe.ac.uk>
Date: Tue, 01 May 2001 16:43:14 +0100
From: Jamie Harris <Jamie.Harris@uwe.ac.uk>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Erin Jones <erin@internationalcomputing.com>
CC: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org,
        bristol@lists.lug.org.uk
Subject: Re: More!! Kernel NULL pointer, over my head... (DOH!)
In-Reply-To: <Pine.WNT.4.33.0105010601460.-1864577-100000@proteus.j-harris.dircon.co.uk> <01c801c0d252$6a916a80$1601b10a@internationalcomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erin Jones wrote:
> 
> are you sure this works:
> gzip -d ; tar xvf myFile.tar.gz?????
> shouldn't it be
> gzip -cd myFile.tar.gz | tar xvf -

I think I have proven myself unworth of your help by producing the
above, obvious to everyone, else cockup.  As unworthy as I am, here I go
again...

As suggested by Phil on Bristol LUG I've fsck'd my filesystems.  Got
something interesting in the process though.  Booted using some
Slackware 7.1 (2.2.16) disks to fsck / and got similar errors to those
already described :(  Yet the system came up...  As there wasn't any
swap configured I can pretty much rule that out, and I had not attempted
to mount any file systems...  These are the same disks I used to carry
out the inital install and I did't get problems then...  I am starting
to think Hardware but have been told that a copy of ksymoops might shed
some more light...

Thanks again.


Jamie...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 ***    Slowly and surely the UNIX crept up on the Nintendo user...   
***
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-----BEGIN GEEK CODE BLOCK-----Version: 3.1
GCS/ED d-(++) s:+ a- C+++>++++$ U+++>$ P++++ L+++>+++++ E+(---) W++ N o?
K? w(++++) O- M V? PS PE? Y PGP- t+ 5 X- R- tv- b++ DI++ D+++ G e++ h*
r++>+++ y+++
------END GEEK CODE BLOCK------
