Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSLBAag>; Sun, 1 Dec 2002 19:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSLBAag>; Sun, 1 Dec 2002 19:30:36 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:64903 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262881AbSLBAaf>; Sun, 1 Dec 2002 19:30:35 -0500
Message-ID: <3DEAA660.60004@enib.fr>
Date: Mon, 02 Dec 2002 01:16:32 +0100
From: XI <xizard@enib.fr>
Reply-To: xizard@enib.fr
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
References: <3DEA322B.40204@enib.fr> <1038765233.30392.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sun, 2002-12-01 at 16:00, XI wrote:
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
> Make sure you have the XFree86 settings for the Matrox right -in
> paticular the PCI retry option
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Thanks for the reply,

Yes, PciRetry option is on in file XF86Config-4; and as I said in my 
previous mail, changing kernel-2.4.20 to 2.4.8 just solves the problem 
(ie I change nothing else).

I was thinking about a problem with my chipset (AMD760MPX, motherboard 
tyan tiger MPX); because I have done some tests on a PC with a matrox 
G200 PCI and a sound blaster live, with a chipset via KT333 and the 
problem doesn't seems to occur. Is it possible?

Xavier

