Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289418AbSAJMXx>; Thu, 10 Jan 2002 07:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289419AbSAJMXo>; Thu, 10 Jan 2002 07:23:44 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:60945
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S289418AbSAJMX0>; Thu, 10 Jan 2002 07:23:26 -0500
Message-ID: <3C3D87A5.10800@inet6.fr>
Date: Thu, 10 Jan 2002 13:23:01 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020107
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <Pine.LNX.4.33L.0201101010090.2985-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Wed, 9 Jan 2002, Jim Crilly wrote:
>
>>Actually it would seem this is just Andre's, not so subtle, way of
>>trying to prove that his ATA133/48-bit addressing patches need
>>included in 2.4.
>>
>
>I think you'll agree with him the moment you end up with
>a cheap 160 GB drive in your machine and the old driver
>(which is limited to 32(?)-bit LBA) won't let you use a
>
28-bit addressing space with 512 byte sectors in fact.
Max corresponding capacity : 2^28 x 512  = 2^37 = 128 GiB ~ 137 GB

LB.

