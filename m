Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310790AbSCMQlx>; Wed, 13 Mar 2002 11:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310796AbSCMQlp>; Wed, 13 Mar 2002 11:41:45 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:36879 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S310790AbSCMQlf>; Wed, 13 Mar 2002 11:41:35 -0500
Message-ID: <3C8F8131.7070606@linkvest.com>
Date: Wed, 13 Mar 2002 17:41:21 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <E16lBe4-0006ly-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2002 16:41:21.0534 (UTC) FILETIME=[E81B49E0:01C1CAAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:

>Normal for md (/proc/mdstat). Interesting question whether they should be
>there - see what Ingo thinks
>
Ingo? What do you think?

When I cat /proc/partitions, all partitions are there with IO stats but 
MD or LVM have no IO stats.
Shouldn't it be there?

-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@linkvest.com
http://www.linkvest.com
--------------------------------------------------------



