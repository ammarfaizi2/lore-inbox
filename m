Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVHKRpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVHKRpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVHKRpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:45:14 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:20279 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932312AbVHKRpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:45:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rwEwriHlpzn3pyaYTqBS173Fx1rxyFJsBECqJTCPhBAdz4s+UbFcoxru4PGyPdSJNAkOhpDG6c/rzU2SN/vBPDgPaPxH2qOr1sXToQWnEqw/+mICv/0szSHI7qVervdAdwSwSXZ55Qvjto+mnD3Hd4evGGOJ0tmaK7e8YW8EDtc=
Message-ID: <42FB8E91.9040905@gmail.com>
Date: Thu, 11 Aug 2005 19:44:49 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       lgb@lgb.hu, Allen Martin <AMartin@nvidia.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com> <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com> <20050811172718.GJ31019@csclub.uwaterloo.ca>
In-Reply-To: <20050811172718.GJ31019@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen schrieb:

>On Thu, Aug 11, 2005 at 01:20:56PM -0400, Jeff Garzik wrote:
>  
>
>>What specifically does not work, on VIA+AMD64 combination, under Linux?
>>
>>My Athlon64 with VIA chipset works great.
>>    
>>
>
>Mine does too.  Asus A8V Deluxe.  No problems so far.  Everything on the
>board I have tried just works.
>  
>
AMD X2 DualCore?

>Can't say my A7N8X-E Deluxe has any real issues either.  I may only get
>ac97 audio level out of the nifty DSP, but I hardly use sound on the
>system anyhow, so I don't mind.  forcedeth driver works for networking,
>sil3112a sata works with WD drives no problem, nvidia ide controller
>seems to work fine with dvd drives, firewire works, yukon sk98lin works
>  
>
Yes, Marvell, Silicon Image  no problem as they provide OpenSource drivers.
On a normal setup is  nearly everything okay.

I hold up a hardware testlab  to find b** *features* the specification 
don't show/hold.
Things that can go scary for production usage - that's my job.

>too, usb is fine.  No complaints from me.
>  
>
USB works also great for all chipsets :-)

>Len Sorensen
>
>  
>
Michael

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



