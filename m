Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCGPa4>; Wed, 7 Mar 2001 10:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRCGPaq>; Wed, 7 Mar 2001 10:30:46 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:58887 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129854AbRCGPam>; Wed, 7 Mar 2001 10:30:42 -0500
Message-Id: <200103071529.f27FTjO26978@aslan.scsiguy.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@caldera.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver 
In-Reply-To: Your message of "Wed, 07 Mar 2001 15:42:19 +0100."
             <200103071442.PAA14348@ns.caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 08:29:45 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What about simply removing the firmware source and assembler from the
>kernel tree?  We have lots of firmware in the kernel tree for which
>there isn't even firmware  avaible...

What, and not allow others to fix my bugs for me? :-)

Lots of people have embedded this driver just because it is completely
open source.  I'd like to have all distributions be "complete"
distributions.

--
Justin

