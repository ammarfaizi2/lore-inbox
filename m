Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbTGIX5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbTGIXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:54:38 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:13563 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S268755AbTGIXyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:54:05 -0400
Message-ID: <03b501c34677$6a3fe250$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>, <mru@users.sourceforge.net>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <20030709150852.GA11309@work.bitmover.com> <yw1x1xwzwwwk.fsf@users.sourceforge.net>
Subject: Re: Promise SATA 150 TX2 plus
Date: Thu, 10 Jul 2003 02:08:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I don't need RAID and 3ware 8500 is real RAID card.
Thanks for the answers
    Milan Roubal

>> > Thanks for the answer, it has got PDC 20375, not
>> > 20376, but it changes nothing. As Alan mentioned
>> > here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
>> > promise has got their own drivers. Have somebody seen
>> > this drivers really working? My card is not RAID,
>> > its only controller, I want only see the harddrives.
>>
>> Do yourself a favor, and get a Highpoint card instead.
>
> I can't speak to the highpoint card, I don't have one of those.  I do have
> a 3ware 8500-4 which works great.  I believe that I had to use a later
> kernel (2.4.20? .21?) to get it to work but it has been working
flawlessly.
> I'm using it in RAID 10 mode.

The 3ware does real RAID, right?  I think the OP didn't need that.

-- 
Måns Rullgård
mru@users.sf.net


