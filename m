Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUFFNs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUFFNs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUFFNs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:48:56 -0400
Received: from havoc.eusc.inter.net ([213.73.101.6]:48979 "EHLO
	havoc.eusc.inter.net") by vger.kernel.org with ESMTP
	id S263640AbUFFNsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:48:55 -0400
Message-ID: <40C32298.7000305@scienion.de>
Date: Sun, 06 Jun 2004 15:56:40 +0200
From: Sebastian Kloska <kloska@scienion.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Clark <michael@metaparadigm.com>, hugh@veritas.com,
       Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <Pine.LNX.4.44.0406050038120.2163-100000@localhost.localdomain>	<40C2004A.8050706@scienion.de>	<40C28F9C.9050004@metaparadigm.com> <20040605212508.2f30eb59.akpm@osdl.org>
In-Reply-To: <20040605212508.2f30eb59.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Clark <michael@metaparadigm.com> wrote:
>  
>
>>One possibility is code sections incorrectly marked as discardable.
>>    
>>
>
>`make buildcheck' will locate these.
>  
>
 Hmmm .. ? Couldn't find any buildcheck: target in the Makefiles

