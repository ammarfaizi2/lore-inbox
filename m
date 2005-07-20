Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVGTOnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVGTOnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGTOnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:43:45 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:39045 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261255AbVGTOno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:43:44 -0400
Message-ID: <42DE626E.9070907@gmail.com>
Date: Wed, 20 Jul 2005 16:40:46 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rth@twiddle.net,
       dhowells@redhat.com, kumar.gala@freescale.com, davem@davemloft.net,
       mhw@wittsend.com, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       nils@kernelconcepts.de, Lionel.Bouton@inet6.fr,
       benh@kernel.crashing.org, mchehab@brturbo.com.br, laredo@gnu.org,
       rbultje@ronald.bitfreak.net, middelin@polyware.nl, philb@gnu.org,
       tim@cyberelk.net, campbell@torque.net, andrea@suse.de, mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
References: <42DC4873.2080807@gmail.com> <200507201319.42050@bilbo.math.uni-mannheim.de> <42DE3E03.1070401@gmail.com> <200507201556.45034@bilbo.math.uni-mannheim.de>
In-Reply-To: <200507201556.45034@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer napsal(a):

>Jiri Slaby wrote:
>  
>
>>Is there any difference? I don't see any, but... The reading of diff
>>file in this case is not the best, maybe...
>>    
>>
>
>Yes, that was the problem. I would prefer if you could just remove the code 
>instead of commenting it out. This would have made this clearer.
>
>If my editor doesn't fool me you are using spaces for indentation of the 
>while. There has to be a tab.
>  
>
I'm really sorry. I made tabs from spaces and removes ebus old code:
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_3.patch
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_3.patch.bz2

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

