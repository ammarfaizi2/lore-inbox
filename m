Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSH1S0a>; Wed, 28 Aug 2002 14:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318626AbSH1S0a>; Wed, 28 Aug 2002 14:26:30 -0400
Received: from klaatu.zianet.com ([204.134.124.201]:37857 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S318166AbSH1S02>;
	Wed, 28 Aug 2002 14:26:28 -0400
Message-ID: <3D6D0D08.2080305@zianet.com>
Date: Wed, 28 Aug 2002 11:48:56 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Kellner <jdk@kingsmeadefarm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: e1000 strangeness in a dell poweredge 1650
References: <1030555971.3d6d09430f774@webmail.kingsmeadefarm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had no problems with the e1000 and the 1650's
They run at 100Mbs and 1000Mbs fine.  I have had them
working both with RH7.3 and Debian, and even FreeBSD.
Bad NIC? Bad cable? It going into a switch, a hub?  These
things come with two NICs, do both do it?

Steve

Joe Kellner wrote:

>Hello,
>Running a dell poweredge 1650 with two intel e1000/pro's on redhat 7.3.
>We seem to be having a problem with the ethernet cards linking at 100 mbps/FDX 
>and only working for a few seconds (usually around 30 seconds). There are no 
>messages in dmesg other than when the module is loaded (Stating that port0 is 
>up at 100 mbs/FDX). Is this a known issue, and is there a workaround? I can 
>provide more information if needed.
>
>
>Thanks,
>-Joe Kellner
>
>-------------------------------------------------
>sent via KingsMeade secure webmail http://www.kingsmeadefarm.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



