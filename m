Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284536AbRLZKkY>; Wed, 26 Dec 2001 05:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284580AbRLZKkF>; Wed, 26 Dec 2001 05:40:05 -0500
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:23305 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S284536AbRLZKj7>;
	Wed, 26 Dec 2001 05:39:59 -0500
Date: Wed, 26 Dec 2001 11:39:55 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Andries.Brouwer@cwi.nl
Cc: jlladono@pie.xtec.es, linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: 2.4.x kernels, big ide disks and old bios
Message-ID: <20011226103955.GA1890@man.beta.es>
In-Reply-To: <UTC200112251638.QAA94646.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200112251638.QAA94646.aeb@cwi.nl>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Good to hear that it works OK. Sooner or later setmax or something
> similar must become part of the standard kernel, but so far I've
> gotten almost no feedback. Can you give the disk manufacturer and model
> (mail aeb@cwi.nl)?

Well, yes, as I had not said it on my previous mail, I'm not putting any
geometry or anything like that on lilo, the disk I have now working like
that is a 60Gigs Seagate Model=ST340823A which is recogniced by Linux as...

hda: 66055248 sectors (33820 MB) w/512KiB Cache, CHS=4111/255/63, UDMA(33)

Of course after using setmax I can access the hole disk.

I have also tried this on a 80 Gigs Seagate Model=ST380020A and it also
works ok.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
