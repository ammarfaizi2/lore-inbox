Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSIYOx0>; Wed, 25 Sep 2002 10:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261991AbSIYOxZ>; Wed, 25 Sep 2002 10:53:25 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:3089 "EHLO
	rtr.ca") by vger.kernel.org with ESMTP id <S261847AbSIYOxZ>;
	Wed, 25 Sep 2002 10:53:25 -0400
Message-ID: <3D91CF1E.3080606@pobox.com>
Date: Wed, 25 Sep 2002 10:58:38 -0400
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter <cogwepeter@cogweb.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: hdparm -Y hangup
References: <Pine.LNX.4.44.0209231556350.16402-100000@greenie.frogspace.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> 
> Clarification: is it the case that hdparm -Y (sleep) will cool the drive 
> off better than hdparm -y (suspend)?

In theory, -Y is capable of greater power (heat) savings than -y,
but in practice this will be model-specific and probably
will pale in comparism to the huge savings from -y alone.

> 
> I read somewhere that -Y only works on unmounted drives. This appears to 
> be false. Comments?

It should work on the raw drive regardless.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

