Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278702AbRJTAaH>; Fri, 19 Oct 2001 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278703AbRJTA35>; Fri, 19 Oct 2001 20:29:57 -0400
Received: from james.kalifornia.com ([208.179.59.2]:40265 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S278702AbRJTA3n>; Fri, 19 Oct 2001 20:29:43 -0400
Message-ID: <3BD0C4FE.9010805@blue-labs.org>
Date: Fri, 19 Oct 2001 20:27:42 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011016
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [compile bug] 2.4.13-pre4 | i2o_pci.c:165 structure has no member named `pdev'
In-Reply-To: <3BCF44C2.5030504@blue-labs.org> <20011019185603.A13465@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to a few posts the last few days, it's part of an incomplete 
merge betwixt -ac and linus.  I assume it will get completed shortly.

David

Ken Brownfield wrote:

>It looks like this has been an issue since -pre1 -- we've seen this too
>with i2o as a module.  Between .11 and the parport issue with .12, it's
>certainly been interesting recently. :)
>
>Anyone have any news on this?  Sorry if I've missed it.
>
>Thanks much,
>


