Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUCVDom (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 22:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCVDom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 22:44:42 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:44527 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261657AbUCVDok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 22:44:40 -0500
Message-ID: <405E611D.10008@nortelnetworks.com>
Date: Sun, 21 Mar 2004 22:44:29 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Pascal Schmidt <der.eremit@email.de>, Frank Cusack <fcusack@fcusack.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Does Linux sync(2) wait?
References: <1C8xa-5lk-5@gated-at.bofh.it> <E1B54ub-00004H-OC@localhost> <20040322005953.GA12237@dingdong.cryptoapps.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sun, Mar 21, 2004 at 04:30:53PM +0100, Pascal Schmidt wrote:
> 
> 
>>No idea about NFS, but sync(1) does wait. When I push 500M out to my
>>MO drive, the cp operation returns fairly quickly because I usually
>>have more than 500M free memory. Then I run sync(1), which takes
>>about 20 minutes before it returns.
>>
> 
> 20 minutes?!

He did say it was a magneto-optical drive.

Chris


