Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292386AbSB0OWk>; Wed, 27 Feb 2002 09:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292516AbSB0OWb>; Wed, 27 Feb 2002 09:22:31 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:59134 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S292511AbSB0OWR>; Wed, 27 Feb 2002 09:22:17 -0500
Message-ID: <3C7CEA75.3040805@drugphish.ch>
Date: Wed, 27 Feb 2002 15:17:25 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Nathan <wfilardo@fuse.net>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.5-dj2 compile failures
In-Reply-To: <Pine.LNX.4.44.0202271600370.16294-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>>RTC Timer support failed - but maybe I don't need that
>>
>>Generic ESS ES18xx driver also failed to compile, - so no sound here.
>>
> 
> Aargh i think thats me too! I'll have a look.

I sent in patches for the RTC Timer compile fix (interrupt.h was 
missing) last night [1] but I only cc'd to dj and the ALSA maintainer. I 
haven't fixed the ESS driver though.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=101477526613921&w=2

Cheers,
Roberto Nibali, ratz


