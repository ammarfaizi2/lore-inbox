Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWARDse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWARDse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWARDse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:48:34 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:37286 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964809AbWARDsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:48:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2rPdo1ASWmuUCjsxj4Xpo+Vgi4IiNpGAzVU81MLUvB0aGiGtxzu/xLq0LX+hgVWqdzBzcwEBimmZLx550Dp33BPaPjuULbmQKQ5hO59XpWeqvOpCTmNqiUPUsads2cNN+XebbCD3Mb8TSjcgQOBfPq0YgmuWYoRmuh8+hDCP62g=  ;
Message-ID: <43CDB49D.3040305@yahoo.com.au>
Date: Wed, 18 Jan 2006 14:23:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
References: <20060116191556.bd3f551c.diegocg@gmail.com>	<43CC7094.9040404@yahoo.com.au>	<20060117141725.d80a1221.diegocg@gmail.com> <20060118012029.db6bf538.diegocg@gmail.com>
In-Reply-To: <20060118012029.db6bf538.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Tue, 17 Jan 2006 14:17:25 +0100,
> Diego Calleja <diegocg@gmail.com> escribió:
> 
> 
>>>Can you apply the attached patch and try to reproduce the oops?
>>
>>You're saying that I'll have to spend all the afternoon watching
>>DVDs? Well, if the linux kernel needs it!
> 
> 
> 
> I've been running kaffeine for hours and i didn't triggered it, it's
> hard to reproduce :/
> 

That's what I feared. Thanks for trying though.

> I'll continue trying to hit it, even if it was a hardware error
> it should happen again!
> 

Yeah, it is unlikely to hit the same place if it is, but if it
is a rare bug then hopefully that check will catch it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
