Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVBUT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVBUT2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVBUT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:26:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13802 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262075AbVBUSvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:51:47 -0500
Message-ID: <421A2D8F.3050704@pobox.com>
Date: Mon, 21 Feb 2005 13:50:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
CC: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
References: <20050220155600.GD5049@vanheusden.com> <4218C692.9040106@tiscali.de> <20050220180550.GA18606@ime.usp.br> <200502211943.59887.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200502211943.59887.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 20 February 2005 19:05, Rogério Brito wrote:
> 
>>On Feb 20 2005, Matthias-Christian Ott wrote:
>>
>>>Rogério Brito wrote:
>>>
>>>>I am willing to test any patch and configuration (let's call me a
>>>>"guinea pig"), but I don't know what I should do. I have, OTOH,
>>>>reported my problem many times in the past few days. :-(
>>>>
>>>>I will retry sending my message to the list once again, with the
>>>>details (in my case, the message I get is "irq 10: nobody cared!"
>>>>and it is regarding my primary HD on my secondary Promise PDC20265
>>>>controller).
>>
>>First of all, Matthias-Christian, thank you very much for your kind
>>answer.
>>
>>I have already tried contacting the linux-ide mailing list as a CC to my
>>earlier messages, but I got no response. I am including some details in
>>this e-mail. I included Bartlomiej in the CC, as he is listed as general
>>IDE maintainer in the MAINTAINERS file.
> 
> 
> Hi,
> 
> There is no need to cc: me 3x times,
> I'm subscribed to linux-kernel and linux-ide
> so I got your mail 5x times...

You should add this to your procmailrc :)

# Nuke duplicate messages
:0 Wh: msgid.lock
| $FORMAIL -D 32768 msgid.cache

	Jeff



