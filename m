Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291172AbSBLUUF>; Tue, 12 Feb 2002 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291177AbSBLUT4>; Tue, 12 Feb 2002 15:19:56 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:40623 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S291172AbSBLUTp>; Tue, 12 Feb 2002 15:19:45 -0500
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: NyQuist@ntlworld.com (NyQuist), Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 12 Feb 2002 21:18:00 +0100
MIME-Version: 1.0
Subject: Re: nm256_audio.o
CC: bruce@ask.ne.jp (Bruce Harada), linux-kernel@vger.kernel.org (Kernel)
Message-ID: <3C698688.10207.1F1AB32@localhost>
In-Reply-To: <1013531519.9204.33.camel@stinky.pussy> from "NyQuist" at Feb 12, 2002 04:31:59 PM
In-Reply-To: <E16agf6-0002S2-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The same (or related) thing happens with my Acer Travelmate 723TXV. Loading 
the module would lock the machine, but only if i had started Windows 98 before and 
warm booted the machine. After a cold boot, it would complain of a shared resource 
(?) problem, and quit. I have yet to check that fix you mention.


/Pedro

> 
> The Dell only works in 2.4.18pre7-ac3 or higher. Someone finally
> figured out the problem and got me a fix. On other boxes its been fine
> for years - To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


