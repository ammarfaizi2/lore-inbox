Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312361AbSDBMjD>; Tue, 2 Apr 2002 07:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSDBMix>; Tue, 2 Apr 2002 07:38:53 -0500
Received: from customer201-108.iplannetworks.net ([200.69.201.108]:30702 "EHLO
	ntmba.mba") by vger.kernel.org with ESMTP id <S311866AbSDBMil>;
	Tue, 2 Apr 2002 07:38:41 -0500
Message-ID: <3CA98CFE.8030202@laotraesquina.com.ar>
Date: Tue, 02 Apr 2002 07:50:38 -0300
From: Pablo Alcaraz <pabloa@laotraesquina.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: es-ar, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203181213130.12950-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>But it's interesting to see how on an athlon the numbers are
>
>	   3.17: 59
>	  34.94: 62
>	   4.71: 85
>	  54.83: 88
>
>ie roughly 60% take 85-90 cycles, and 40% take ~60 cycles. I don't know
>where that pattern would come from..
>
In an athlon 1Ghz the numbers are:

94.49: 20
 2.51: 21

I don't why the numbers are so different.

Pablo

