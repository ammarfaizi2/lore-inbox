Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266953AbUBMMQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266955AbUBMMQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:16:09 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:53448 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S266953AbUBMMQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:16:08 -0500
Message-ID: <402CBFEF.9050209@jburgess.uklinux.net>
Date: Fri, 13 Feb 2004 12:15:43 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: Michael Frank <mhf@linuxmail.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com> <200402120502.39300.mhf@linuxmail.org>
In-Reply-To: <200402120502.39300.mhf@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:

>Could you please boot with scheduler=deadline to compare apples with apples.
>  
>
The schedular did not make a significant difference, both returned 
0.34MB/s for the worst case.

    Jon

