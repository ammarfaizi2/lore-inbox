Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284935AbRL2AVY>; Fri, 28 Dec 2001 19:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284931AbRL2AVN>; Fri, 28 Dec 2001 19:21:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11281 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284905AbRL2AVD>; Fri, 28 Dec 2001 19:21:03 -0500
Message-ID: <3C2D0C5E.7020401@zytor.com>
Date: Fri, 28 Dec 2001 16:20:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <UTC200112290001.AAA139460.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>>Does anyone have the patch to look at ?
>>
> 
> See http://www.cck.uni-kl.de/misc/tecra710/toshiba-small.diff
> 
> Andries
> 

Also, I would *really* like to find out if the machines that have this 
pathology honours INT 15h, AX=2401h, in which case no external 
workaround should be necessary with the current 2.4 A20 code.

	-hpa

