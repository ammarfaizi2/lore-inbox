Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282506AbRKZVBL>; Mon, 26 Nov 2001 16:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282524AbRKZVBG>; Mon, 26 Nov 2001 16:01:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24335 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282506AbRKZVAc>; Mon, 26 Nov 2001 16:00:32 -0500
Message-ID: <3C02AD4F.3030101@zytor.com>
Date: Mon, 26 Nov 2001 12:59:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: junio@siamese.dhis.twinsun.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva> <7v1yil1d2x.fsf@siamese.dhis.twinsun.com> <20011126215547.O5770@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

>>
>>While we are on the topic, could you also coordinate to keep the
>>EXTRAVERSION strings consistent?  2.4.X-preN uses "-preN" but
>>2.2.X-preN uses "preN" without leading "-".
>>
> 
> I'm using "-preN" with a leading "-", and will probably continue
> doing so.
> 


This matches the filename convention, and seems to be what most users expect.

	-hpa


