Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312409AbSDAQfo>; Mon, 1 Apr 2002 11:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312361AbSDAQfY>; Mon, 1 Apr 2002 11:35:24 -0500
Received: from duneyr.obbit.se ([194.165.245.23]:62696 "EHLO mail.obbit.se")
	by vger.kernel.org with ESMTP id <S312414AbSDAQfO>;
	Mon, 1 Apr 2002 11:35:14 -0500
Message-ID: <3CA88BC0.2000603@2gen.com>
Date: Mon, 01 Apr 2002 18:33:04 +0200
From: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9+) Gecko/20020325
X-Accept-Language: en,sv
MIME-Version: 1.0
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter
In-Reply-To: <Pine.LNX.4.44.0203301850410.24920-100000@pc24.sr.bham.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Cooke wrote:

> If I run a simultaneous one on hdc and hde, the combined rate tops 
> out at 50MB again.  Hence, the limitation isn't the raid card.  Or at 
> least I'd be exceedingly surprised.
> 

The bugs that exist in VIA chipsets and Barracuda drives have already 
exceedingly surprised me many, many times :-)

I have done some dumping on the via chipset and this what I've come up 
with is available (in a cooked format) at:
http://www.student.nada.kth.se/~i99_hnd/via/

I hope that this is useful in some way for you?.

Regards,
David


