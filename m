Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSGKQ6p>; Thu, 11 Jul 2002 12:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317860AbSGKQ6o>; Thu, 11 Jul 2002 12:58:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15878 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317859AbSGKQ6n> convert rfc822-to-8bit; Thu, 11 Jul 2002 12:58:43 -0400
Message-ID: <3D2DB9DF.4010002@evision-ventures.com>
Date: Thu, 11 Jul 2002 19:01:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <3D2CA6E3.CB5BC420@zip.com.au> <20020710173555.D2005@redhat.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Benjamin LaHaise napisa³:
> On Wed, Jul 10, 2002 at 02:28:03PM -0700, Andrew Morton wrote:
> 
>>>But on the other hand, increasing HZ has perf/latency benefits, yes? Have
>>>these been quantified?
>>
>>Not that I'm aware of.  And I'd regard any such claims with some
>>scepticism.
> 
> 
> The most obvious one is the reduced latency of select/poll timeouts.

Which you can actually see if running x11perf or simple ico.

