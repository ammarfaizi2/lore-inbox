Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317161AbSEXPb0>; Fri, 24 May 2002 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317158AbSEXPbZ>; Fri, 24 May 2002 11:31:25 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:58356 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317157AbSEXPbY>; Fri, 24 May 2002 11:31:24 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E17BGhc-0006V7-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mulix@actcom.co.il (Muli Ben-Yehuda), linux-kernel@vger.kernel.org
Subject: Re: ppp_deflate.o taints the kernel? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 May 2002 16:31:11 +0100
Message-ID: <29311.1022254271@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  FAQ item - BSD license doesnt guarantee we have source. If its GPL
> compatible someone should slap a GPL header on our copy and be done
> with it

It's already marked 'Dual BSD/GPL' in your tree and in 2.5, I believe.
I fixed it when I did the zlib changes.

--
dwmw2


