Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSDSAUP>; Thu, 18 Apr 2002 20:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314515AbSDSAUN>; Thu, 18 Apr 2002 20:20:13 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:47567 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S314514AbSDSAUL>; Thu, 18 Apr 2002 20:20:11 -0400
Message-ID: <3CBF6718.6010305@tmg99.ntes.nec.co.jp>
Date: Fri, 19 Apr 2002 09:38:48 +0900
From: "Adrian V. Bono" <g_adrian@tmg99.ntes.nec.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: something weird on Linux 2.4.17 on an IBM Thinkpad T20
In-Reply-To: <3CBF6225.6050605@tmg99.ntes.nec.co.jp> <20020419000928.GB28956@turbolinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Apr 19, 2002  09:17 +0900, Adrian V. Bono wrote:
> 
>>While working in X on kernel 2.4.17 on an IBM Thinkpad T20, sometimes 
>>the mouse pointer would just gravitate all by itself, without my moving 
>>the mouse or pointing stick, upwards. The first time that happened, i 
>>was coding in an xterm when suddenly, window focus shifted to another 
>>window and i noticed the mouse pointer was moving upwards by itself. 
>>Anyone else notice this?
> 
> 
> This is common to all thinkpads (or other laptops which have trackpoint
> devices) and also happens under Windows.  The cause is related to
> automatic compensation for the centering of the trackpoint.  Early
> trackpoint devices didn't have automatic centering and I remember
> replacing more than a few keyboards because the mouse would start
> drifting by itself.  Later trackpoints have automatic centering, but
> if you hold onto the trackpoint for a long time (causing the "center"
> to be offset by some amount) and then let go, it will settle back to
> the "old center" and the cursor will drift for a few seconds until
> the automatic centering kicks in again.
> 
> Moral of the story - don't touch the trackpoint when you aren't doing
> anything with it.
> 


Yes, i've replied two replies similar to yours. But it happens to my 
desktop, too.


