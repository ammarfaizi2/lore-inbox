Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVBRQP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVBRQP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVBRQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:15:57 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:50182 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S261285AbVBRQPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:15:53 -0500
X-ME-UUID: 20050218161551300.492DE2400194@mwinf1012.wanadoo.fr
Message-ID: <42161455.7030204@innova-card.com>
Date: Fri, 18 Feb 2005 17:14:13 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-os@analogic.com, Paul Fulghum <paulkf@microgate.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com> <421604DD.4080809@grupopie.com> <4216068E.90205@microgate.com> <Pine.LNX.4.61.0502181020480.23519@chaos.analogic.com> <42160973.5070808@grupopie.com>
In-Reply-To: <42160973.5070808@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Ahaa!  That's how the bug got introduced. It used to be an
>> array and then it got changed to a pointer! linux-2.4.26
>> also shows a local array.
>
>
> Yes, just looked at the revision history in linux.bkbits.net and Linus 
> just fixed this 67 hours ago... So we're too late :)
>
ok, maybe next time :)

          Franck

