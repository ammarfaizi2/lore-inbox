Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKNRd4>; Wed, 14 Nov 2001 12:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKNRdr>; Wed, 14 Nov 2001 12:33:47 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:18069 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S272818AbRKNRdi>;
	Wed, 14 Nov 2001 12:33:38 -0500
Message-ID: <3BF2AAB9.5050800@stesmi.com>
Date: Wed, 14 Nov 2001 18:32:41 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney> <3BF285D7.8F5AAB6E@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

 >>Hi folks - I'm having real problems getting our new dual CPU server
 >>going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
 >>
 >
 > Ehm you know that XP cpu's don't support SMP configuration ?

Not totally true. AMD doesn't support them in SMP configuration. Ie, 
they run, but if it breaks you get to keep the pieces.

On the MPs, if it breaks, AMD might help you out.

// Stefan


