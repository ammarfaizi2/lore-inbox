Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288013AbSABXhr>; Wed, 2 Jan 2002 18:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288027AbSABXg3>; Wed, 2 Jan 2002 18:36:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9740 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288020AbSABXf7> convert rfc822-to-8bit; Wed, 2 Jan 2002 18:35:59 -0500
Message-ID: <3C339608.6030201@zytor.com>
Date: Wed, 02 Jan 2002 15:21:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
CC: robert@schwebel.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201021823210.3056-100000@callisto.local> <3C339284.3F88FE68@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g02NLiS03088
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:

>>
>>Model  0ah means "enhanced Am486 SX1 write back mode"
>>Family 04h means "Am486 CPU"
>>
>>Which IMHO doesn't say that this combination means _exactly_ the SC410.
>>
> IIRC the difference between SC410 and SC400 is an embedded PCMCIA controller
> and perhaps a LCD controller.
> The CPU core should be the same.
> 

The problem is that we're talking about problems in the chipset portion.

	-hpa

