Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbVKIAV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbVKIAV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVKIAV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:21:56 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:43756 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030459AbVKIAVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:21:55 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Calin Szonyi <caszonyi@rdslink.ro>
Subject: Re: New Linux Development Model
Date: Wed, 9 Nov 2005 11:23:51 +1100
User-Agent: KMail/1.8.3
Cc: jerome lacoste <jerome.lacoste@gmail.com>,
       Edgar Hucek <hostmaster@ed-soft.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <436C7E77.3080601@ed-soft.at> <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com> <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
In-Reply-To: <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511091123.52092.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005 11:11 am, caszonyi@rdslink.ro wrote:
> There are other reasons for using a new kernel. One of them is
> interactivity. In the days of 2.4 one could achieve decent interactivity
> for the desktop using preempt and low latency patches. For 2.6
> interactivity was a real issue (possibly because of the new development
> model).

Eh? Where are the bug reports for this? I've only seen better interactivity 
and responsiveness with 2.6. 

The only time I've seen bad behaviour repeatedly on forums and elsewhere has 
been due to misconfigured IDE drivers not using DMA and X servers still 
reniced to -10.

Cheers,
Con
