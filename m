Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279860AbRKNAYf>; Tue, 13 Nov 2001 19:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279829AbRKNAYZ>; Tue, 13 Nov 2001 19:24:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29971 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279860AbRKNAYI>; Tue, 13 Nov 2001 19:24:08 -0500
Message-ID: <3BF1B997.5030908@zytor.com>
Date: Tue, 13 Nov 2001 16:23:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pascal Schmidt <pleasure.and.pain@web.de>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: fdutils.
In-Reply-To: <Pine.LNX.4.33.0111140119580.1217-100000@neptune.sol.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt wrote:

> On Tue, 13 Nov 2001, Richard B. Johnson wrote:
> 
> 
>>Without a floppy-based rescue system, you have to use bootable CDROM,
>>usually supplied by a vendor, without the tools to truly rescue a
>>system. You can only re-install. For instance some vendors don't
>>provide a SCSI-tape module so you can't recover from a SCSI tape.
>>
> 
> There are a few minimalistic distributions that can be burned onto CDROM 
> for rescue operations. Just add your favourite kernel with all your 
> required drivers and you are ready to go.
> 
> Shameless plug: I use my own distribtion
> 	http://www.tzi.de/~pharao90/ttylinux/
> for the same purpose. ;)
> 


And some not-so-minimalistic systems... you can fit an awful lot on a CD.

	http://www.kernel.org/pub/dist/superrescue/

	-hpa


