Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSDRJWX>; Thu, 18 Apr 2002 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314280AbSDRJWW>; Thu, 18 Apr 2002 05:22:22 -0400
Received: from relay04.esat.net ([193.95.141.42]:36622 "EHLO relay04.esat.net")
	by vger.kernel.org with ESMTP id <S314278AbSDRJWV>;
	Thu, 18 Apr 2002 05:22:21 -0400
Message-ID: <3CBE8FBB.8080108@palamon.ie>
Date: Thu, 18 Apr 2002 10:19:55 +0100
From: Tony Clarke <sam@palamon.ie>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM Related question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed with my current kernel that after the system is idle for 
a while, say 10 hours or
so, that everything seems to be swapped out to disk. So when I come in 
the next morning
it starts swapping everything like crazy in from disk. Is this a known 
characteristic of the
VM. I seem to remember this with all 2.4 kernels tried to date.

Whats the point of swapping out to disk in circumstances like this?

Currently I am using 2.4.18-rc2-ac2, with apps like mozilla, dozen 
xterms, xemacs, staroffice etc.

Cheers,
Tony.

