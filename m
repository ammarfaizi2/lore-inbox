Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSLBAay>; Sun, 1 Dec 2002 19:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSLBAay>; Sun, 1 Dec 2002 19:30:54 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:49557 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262884AbSLBAaw>; Sun, 1 Dec 2002 19:30:52 -0500
Message-ID: <3DEAA671.5090008@enib.fr>
Date: Mon, 02 Dec 2002 01:16:49 +0100
From: XI <xizard@enib.fr>
Reply-To: xizard@enib.fr
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
References: <3DEA322B.40204@enib.fr> <1038768875.12518.2.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GrandMasterLee wrote:
> On Sun, 2002-12-01 at 10:00, XI wrote:
> 
>>Hi,
>>[1] With kernel-2.4.19 and kernel-2.4.20 the sound stutter, sizzle
>>
>>[2] The problem seems be correlated with my PCI graphic card (matrox
>>G200 PCI) and my sound card (sound blaster live 5.1).
>>In fact every time I listen music and that something appens on my screen
>>(moving a window, watching a movie) the sound stutter.
> 
> 
> I had a similar problem. Turned out to be where my TV card was plugged
> into + my mixer settings. I had the tv sound out plugged into mic,
> instead of line in. Using aumix I was able to figure out that changing
> which input was allowed to recored got rid of the noise. Have you
> attempted such trouble shooting?
> 
> 
>>I think the first thing I should do is to try different kernel version
>>in order to find when this problem appeared first.
> 
> 
> --The GrandMaster
> 

Thanks for the reply,

I don't think this is the problem, because nothing is plugged into mic 
or line in; and all settings are set to 0 in aumix except Vol, Pcm and 
OGain.


Xavier

