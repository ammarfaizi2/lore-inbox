Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSHHSXb>; Thu, 8 Aug 2002 14:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSHHSXb>; Thu, 8 Aug 2002 14:23:31 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:28157 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S317667AbSHHSX3>; Thu, 8 Aug 2002 14:23:29 -0400
Message-ID: <3D52B7D3.2000209@verizon.net>
Date: Thu, 08 Aug 2002 14:26:27 -0400
From: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
References: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com>	<3D51DD80.6070501@verizon.net> <20020808075536.GB943@alpha.home.local> 	<3D529154.8090304@verizon.net> <1028835824.28882.57.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a national semi chip ... the module name is natsemi.o,
and indeed I am using it without incident now in place of fa312.o.

All of my modules are now GPL according to modinfo, so if the problem
reoccurs now that I've rebooted we'll know if it's real.

-- tony

Alan Cox wrote:

>On Thu, 2002-08-08 at 16:42, Anthony Russo., a.k.a. Stupendous Man
>wrote:
>  
>
>>AFAIK, the only proprietary module that is loaded is the fa312,
>>which is a driver for my ethernet card,  which is still loaded
>>and has never caused any problems for the 1.5 years I've used it.
>>    
>>
>
>You should be able to swap the fa312 driver for the matching open source
>driver anyway. If I remember rightly isnt the 312 a realtek ?
>
>
>  
>

-- 
"Surrender to the Void."
<http://162.83.143.240:8080/%7Eapr/surrenderToTheVoid.mp3> -- John Lennon


