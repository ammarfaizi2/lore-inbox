Return-Path: <linux-kernel-owner+w=401wt.eu-S932793AbWLNPRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWLNPRl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLNPRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:17:41 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:50876 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932774AbWLNPRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:17:40 -0500
Message-ID: <45816B11.9040309@lwfinger.net>
Date: Thu, 14 Dec 2006 09:17:37 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Mike Christie <michaelc@cs.wisc.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression in v2.6.19-git18: Unable to write CD
References: <4580DD6F.8060907@lwfinger.net> <20061214072129.GW4576@kernel.dk>
In-Reply-To: <20061214072129.GW4576@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Dec 13 2006, Larry Finger wrote:
>> There is a regression in v2.6.19-rc18 that makes one unable to write CD's. 
>> In k3b, the drive status shows no devices. I used git bisect to find the 
>> bad commit is the following:
> 
> Try a newer snapshot, it was fixed a few days ago.
> 

-git19 or -git20 fixed the problem.

Thanks,

Larry

