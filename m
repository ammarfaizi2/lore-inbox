Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSEIEOF>; Thu, 9 May 2002 00:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSEIEOE>; Thu, 9 May 2002 00:14:04 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:898 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S315606AbSEIEOE>; Thu, 9 May 2002 00:14:04 -0400
Message-ID: <3CD81676.90909@notnowlewis.co.uk>
Date: Tue, 07 May 2002 19:01:26 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lost interrupt hell - Plea for Help
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

*bang*

*bang*

Hear that? Its my head, against the wall. ;)

I am trying to convert my audio cds to mp3, which involves first ripping 
the track as a wav.

I have two drives, one Creative DVD 5x, one LG CDRW drive.
My chipet is VIA K7 266 pro, 1.2ghz duron.

I have tried every combination of master / slave between the two drives, 
the drives on their own, scsi emulation through ide-scsi, purely as IDE 
drives, ommitting ide cdrom support from teh kernel completely and only 
using ide-scsi... every time I try to get a track ripped, dmesg fills up 
with hdX: lost interrupt.

If I try to rip from the DVD drive, the system hangs and its reset 
button time.

I am using 2.4.18.

Can anyone tell me where I'm going wrong? Is there anything from my 
system you need to see to help me?

Many thanks,

mikeH

