Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUFEHzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUFEHzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUFEHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:55:21 -0400
Received: from havoc.eusc.inter.net ([213.73.101.6]:17224 "EHLO
	havoc.eusc.inter.net") by vger.kernel.org with ESMTP
	id S264546AbUFEHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:55:14 -0400
Message-ID: <40C17E59.2080103@scienion.de>
Date: Sat, 05 Jun 2004 10:03:37 +0200
From: Sebastian Kloska <kloska@scienion.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Duthie <psycho@albatross.co.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de> <Pine.LNX.4.53.0406051105170.27816@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0406051105170.27816@loki.albatross.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 No i2c is completely disabled


Keith Duthie wrote:

>On Fri, 4 Jun 2004, Sebastian Kloska wrote:
>
>  
>
>>After all this bashing...
>>
>>Is there anyone out there who has the same experiences ?
>>    
>>
>
>I had the same problem at one time. Does disabling i2c help at all??
>
>If so, the problem is probably in the w83781d or w83627hf driver; I could
>send you a copy of the patch, or you could just get the latest i2c release
>from http://www2.lm-sensors.nu/~lm78/index.html
>  
>


