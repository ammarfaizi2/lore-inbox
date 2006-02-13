Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWBMQ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWBMQ1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBMQ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:27:54 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:45300 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750808AbWBMQ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:27:53 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 17:26:21 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0B32D.nailKUS1E3S8I3@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD>
 <43EC88B8.nailISDH1Q8XR@burner> <43EFC1FF.7030103@vilain.net>
 <43F097AE.nailKUSK1MJ9O@burner>
 <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE>
 <20060213095038.03247484.seanlkml@sympatico.ca>
 <43F0A771.nailKUS131LLIA@burner>
 <mj+md-20060213.160108.13290.atrey@ucw.cz>
In-Reply-To: <mj+md-20060213.160108.13290.atrey@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> Hello!
>
> > If there is no interest to fox well known bugs in Linux, I would need to warn
> > people from using Linux.
>
> Except for mentioning some DMA related problems at the beginning of this
> monstrous thread, you haven't shown anything which even remotely qualifies
> as a bug.

If you forget these things, then please forget about this thread.

I mentioned:

-	ide-scsi does not do DMA correctly

-	SCSI commands are bastardized on ATAPI 

If you like, I can give you many other Linux related bugs but it does
not make sense unless the two bugs above are fixed.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
