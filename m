Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281394AbRKEWQH>; Mon, 5 Nov 2001 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281396AbRKEWPt>; Mon, 5 Nov 2001 17:15:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6924 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281394AbRKEWPh>; Mon, 5 Nov 2001 17:15:37 -0500
Message-ID: <3BE70F77.7030002@zytor.com>
Date: Mon, 05 Nov 2001 14:15:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Limited RAM - how to save it?
In-Reply-To: <E160s6q-0006o6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>4 MB was the practical minimum for even the very early versions of
>>Linux.  I would probably suggest backrevving to 2.0 (which is still
>>maintained) or even 1.2 (which isn't) for a start...
>>
> There is no 1.2 kernel tree that is secure from remote attack
> 

Doesn't matter much if your system is a standalone embedded system, does
it?  (Not that I know if the original poster's system was such, but such
systems definitely exist in plenty.)

	-hpa

