Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSFFIBq>; Thu, 6 Jun 2002 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSFFIBp>; Thu, 6 Jun 2002 04:01:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28428 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316869AbSFFIBo>; Thu, 6 Jun 2002 04:01:44 -0400
Message-ID: <3CFF0926.3090206@evision-ventures.com>
Date: Thu, 06 Jun 2002 09:03:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Mike Fedyk <mfedyk@matchmail.com>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Thomas Zimmerman <thomas@zimres.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] atapci 0.51
In-Reply-To: <Pine.SOL.4.30.0206051820380.16024-100000@mion.elka.pw.edu.pl> <20020601025555.GA291@zimres.net> <Pine.SOL.4.30.0206051820380.16024-100000@mion.elka.pw.edu.pl> <5.1.0.14.2.20020606085533.00aede30@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> At 03:55 06/06/02, Mike Fedyk wrote:
> 
>> On Wed, Jun 05, 2002 at 06:21:47PM +0200, Bartlomiej Zolnierkiewicz 
>> wrote:
>> >
>> > On Fri, 31 May 2002, Thomas Zimmerman wrote:
>> >
>> > > On 31-May 02:35, Bartlomiej Zolnierkiewicz wrote:
>> > > [snip]
>> > > > So 0.51 version is here:
>> > > > http://home.elka.pw.edu.pl/~bzolnier/atapci/atapci-0.51.tar.bz2
>> > > >
>> > > > changelog:
>> > > > - make it kernel version independent
>> > > > - add '-s' strip flag to CFLAGS
>> > > > - minor cosmetics by Roberto Nibali
>> > > >
>> > > > --
>> > > > bkz
>> > >
>> > > Just a nit, but wouldn't the name "lsata" fit in better with 
>> "lspci" and
>> > > "lsisa"?
>> > >
>> > > Thomas
>> > >
>> >
>> > No, it is only for PCI chipsets.
>>
>> I think he meant to follow the naming convention set by lspci and lsisa.
>> What do you think now?
> 
> 
> Well the comment that it only applies to pci chipsets still applies. A 
> compromise would be lsatapci I guess...

Well the best thing would be to integrate it with hdparm and ide-smart anyway...

