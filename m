Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbTHFLjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273000AbTHFLjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:39:16 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:14034 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270739AbTHFLjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:39:15 -0400
Message-ID: <3F30E8E1.6080407@mrs.umn.edu>
Date: Wed, 06 Aug 2003 06:39:13 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu> <20030806034842.1ec1ba38.dickson@permanentmail.com>
In-Reply-To: <20030806034842.1ec1ba38.dickson@permanentmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dickson wrote:
> On Tue, 05 Aug 2003 21:30:48 -0500, Grant Miner wrote:
> 
> 
>>The first item number is time, in seconds, to complete the test (lower 
>>is better).  The second number is CPU use percentage (lower is better).
>>
>>reiser4 171.28s, 30%CPU (1.0000x time; 1.0x CPU)
>>reiserfs 302.53s, 16%CPU (1.7663x time; 0.53x CPU)
>>ext3 319.71s, 11%CPU	(1.8666x time; 0.36x CPU)
>>xfs 429.79s, 13%CPU (2.5093x time; 0.43x CPU)
>>jfs 470.88s, 6%CPU (2.7492x time 0.02x CPU)
> 
> 
> That should be 0.20x CPU for jfs, right?
> 
> 	-Paul
> 
> 
yes, that's right.

