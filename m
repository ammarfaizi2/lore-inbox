Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261995AbSIYPDD>; Wed, 25 Sep 2002 11:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSIYPDD>; Wed, 25 Sep 2002 11:03:03 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:55824 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S261995AbSIYPDC>;
	Wed, 25 Sep 2002 11:03:02 -0400
Message-ID: <3D91D0F2.5080806@corvil.com>
Date: Wed, 25 Sep 2002 16:06:26 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <mlord@pobox.com>
CC: Peter <cogwepeter@cogweb.net>, linux-kernel@vger.kernel.org
Subject: Re: hdparm -Y hangup
References: <Pine.LNX.4.44.0209231556350.16402-100000@greenie.frogspace.net> <3D91CF1E.3080606@pobox.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Peter wrote:
> 
>>
>> Clarification: is it the case that hdparm -Y (sleep) will cool the 
>> drive off better than hdparm -y (suspend)?
> 
> 
> In theory, -Y is capable of greater power (heat) savings than -y,
> but in practice this will be model-specific and probably
> will pale in comparism to the huge savings from -y alone.

True. Is there any chance you could mark -Y (DANGEROUS).
Even if it is dangerous currently because of an IDE bug
it still is dangerous.

>> I read somewhere that -Y only works on unmounted drives. This appears 
>> to be false. Comments?
> 
> It should work on the raw drive regardless.

thanks,
Pádraig.

