Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUFGPLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUFGPLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUFGPLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:11:30 -0400
Received: from mail.scienion.de ([141.16.81.54]:5763 "EHLO
	server03.hq.scienion.de") by vger.kernel.org with ESMTP
	id S264755AbUFGPJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:09:15 -0400
Message-ID: <40C48519.6010703@scienion.de>
Date: Mon, 07 Jun 2004 17:09:13 +0200
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Keith Duthie <psycho@albatross.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz> <40C47FEE.6080505@scienion.de> <20040607145116.GE1467@elf.ucw.cz>
In-Reply-To: <20040607145116.GE1467@elf.ucw.cz>
X-MIMETrack: Itemize by SMTP Server on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 17:18:16,
	Serialize by Router on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 17:18:17,
	Serialize complete at 07.06.2004 17:18:17
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>> The pure ALSA system with PCI Cirrus Logic CS4281
>> (my configuration) just dropped of my list of
>> the 'bad' one ....
>>
>> Does this bug freeze the machine ? Or just block
>> the outputting program ?
>>
>> PCM will be the next to look at...
> 
> 
> Drop all non-important hw. That's everything but keyboard, VGA and
> harddrive...
> 
    Already did that and APM suspends/resumes fine. That gives
   me hope to at least pinpoint the bad behaving module/driver....


> 
>> +-compile->reboot->check->-+
>> ^                          |
>> |                          |
>> +---<----------------------+
>>
>> Kind of feel like in the old days where
>> a decend 'printf(stderr,....)' was THE
>> state of the art debugging tool ....
> 
> 
> Its *still* state of the art debugging tool for kernel.

    Tears of sentimental to reminisce wet my eyes ... :-)

> 								Pavel


-- 
**********************************
Dr. Sebastian Kloska
Head of Bioinformatics
Scienion AG
Volmerstr. 7a
12489 Berlin
phone: +49-(30)-6392-1708
fax:   +49-(30)-6392-1701
http://www.scienion.de
**********************************
