Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266773AbRGFRzD>; Fri, 6 Jul 2001 13:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266774AbRGFRyy>; Fri, 6 Jul 2001 13:54:54 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:32592 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266773AbRGFRyh>; Fri, 6 Jul 2001 13:54:37 -0400
Message-ID: <3B45FB4A.9010807@humboldt.co.uk>
Date: Fri, 06 Jul 2001 18:54:18 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010531
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ariel Molina Rueda <amolina@fismat.umich.mx>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via82cxxx Codec rate locked at 48Khz
In-Reply-To: <Pine.LNX.4.33.0107061215400.32589-100000@garota.fismat.umich.mx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ariel Molina Rueda wrote:


> When i used Redhat 7 and kernel 2.2.x y was happy with my souncard, now I
> use RedHat 7.1 and Kernel 2.4.x, but sndconfig doesn't configure my
> Via82c686 soundcard at all. At the ending it says
> 
> via82cxxx codec rate locked at 48khz


Is this with 2.4.6 or an earlier version? 2.4.6 contained new code for 
talking to the codec.

-- 
Adrian Cox   http://www.humboldt.co.uk/

