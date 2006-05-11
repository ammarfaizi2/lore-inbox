Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWEKNXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWEKNXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWEKNXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:23:24 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:787 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751768AbWEKNXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:23:23 -0400
Message-ID: <44633AC5.9090309@argo.co.il>
Date: Thu, 11 May 2006 16:23:17 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Giacomo A. Catenazzi" <cate@cateee.net>
CC: Mark Hedges <hedges@ucsd.edu>, David Rees <drees76@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
References: <20060510135100.F26270@network.ucsd.edu> <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com> <20060510225112.T31828@network.ucsd.edu> <4463321C.3060403@cateee.net>
In-Reply-To: <4463321C.3060403@cateee.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2006 13:23:20.0256 (UTC) FILETIME=[12342400:01C674FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi wrote:
> Mark Hedges wrote:
>> Just a wishlist that process IO could be monitored.  I hate to say it 
>> but ctl-alt-esc in W2K can monitor io by process, and that's really 
>> useful.  (I will never go back though.)
>
> vmstat ?

He's looking for per process stats.

-- 
error compiling committee.c: too many arguments to function

