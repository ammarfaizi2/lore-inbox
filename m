Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbSIZVaK>; Thu, 26 Sep 2002 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSIZVaK>; Thu, 26 Sep 2002 17:30:10 -0400
Received: from host.greatconnect.com ([209.239.40.135]:33036 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S261519AbSIZVaJ>; Thu, 26 Sep 2002 17:30:09 -0400
Message-ID: <3D937ED7.8070105@rackable.com>
Date: Thu, 26 Sep 2002 14:40:39 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx support for aic7902?
References: <A5974D8E5F98D511BB910002A50A66470580D20D@hdsmsx103.hd.intel.com > <1338716224.1032976056@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:

>>Justin,
>>
>>I've seen a special U320 driver aic79xx v1.10, but I suppose that the new
>>U320 controllers will be folded into a new version of your aic7xxx driver
>>(?).
>>    
>>
>
>Nope.  The U320 chips will never be supported in the aic7xxx driver due
>to their very different architecture.  aic79xx v1.1.0 (or 1.1.1 which
>includes the port to the 2.5.X kernels) is what you want.
>


  Where can I find the v1.1.0 patch?

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



