Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbULAK5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbULAK5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbULAK5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:57:46 -0500
Received: from 92.Red-80-34-142.pooles.rima-tde.net ([80.34.142.92]:42572 "EHLO
	samsagaz.sirte.net") by vger.kernel.org with ESMTP id S261367AbULAKz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:55:57 -0500
Message-ID: <41ADA35E.2010801@sombragris.com>
Date: Wed, 01 Dec 2004 11:56:30 +0100
From: Miguel Angel Flores <maf@sombragris.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; es-ES; rv:1.7) Gecko/20040616
X-Accept-Language: es-es, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Joe Hsu <joe@softwell.com.tw>
Subject: Re: Kernel 2.6 with X (xorg) 4.4 (eats more CPU power)
References: <1101896505.2161.45.camel@joe>
In-Reply-To: <1101896505.2161.45.camel@joe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Dec 2004 10:56:30.0265 (UTC) FILETIME=[69C1B290:01C4D794]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its just an idea but... ¿Have you configured your 2.6 kernel as a 
Preemptive kernel?

Cheers,
MaF

Joe Hsu escribió:

>     In contrast, I've tried Kernel 2.4 with same X, same 
> program, and same machine. It consumes almost zero of CPU 
> resource( no matter it runs on a P4 1.xG or P4 3.0G and no
> matter it runs on 4.4 or 4.2 X-server).
> 
>     Same phenomenon happened when I ran 4 mpeg4 playback 
> programs (each 320x240, 30 frames per second, no scaling).
> It seems that these programs and X consume almost zero of 
> CPU power when the KERNEL HZ is 100. (I've 
> tried Robert Love's variable HZ patch to kernel 2.4 and 
> change HZ to 1000........Same phenomenon as 2.6)
