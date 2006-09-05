Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWIENlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWIENlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWIENlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:41:15 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:47285 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965023AbWIENlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:41:13 -0400
Message-ID: <44FD7DB3.3060406@aitel.hist.no>
Date: Tue, 05 Sep 2006 15:37:55 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <E1GKKiV-0006P7-00@calista.eckenfels.net>
In-Reply-To: <E1GKKiV-0006P7-00@calista.eckenfels.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <200609041529.k84FTolf004383@turing-police.cc.vt.edu> you wrote:
>   
>> Memory is indeed cheap.  However, if you're already at the max supported
>> memory configuration for your system, buying another RAM socket to plug that
>> cheap memory card into can be *really* expensive.
>>     
>
> Dont expect any useable system performance if you swap regularly.
>   
Not entirely correct.  Performance with continous swapping will
be fine as long as the swap bandwidth is lower than available disk
bandwidth. 

This is a narrow line to walk though, memory bandwidth being
much higher than disk bandwith so it don't take much more
swapping before performance drops like a rock.

Helge Hafting

