Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275790AbRI1CNR>; Thu, 27 Sep 2001 22:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275791AbRI1CNI>; Thu, 27 Sep 2001 22:13:08 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:44174 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S275790AbRI1CNA>;
	Thu, 27 Sep 2001 22:13:00 -0400
Message-ID: <3BB3DC79.1030502@stesmi.com>
Date: Fri, 28 Sep 2001 04:12:09 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: CPU frequency shifting "problems"
In-Reply-To: <E15mlwM-0005g5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.

>>For example, the Intel "SpeedStep" CPU's are completely broken under
>>Linux, and real-time will advance at different speeds in DC and AC modes,
>>because Intel actually changes the frequency of the TSC _and_ they don't
>>document how to figure out that it changed.
> 
> The change is APM or ACPI initiated. Intel won't tell anyone anything
> useful but Microsoft have published some of the required intel confidential
> information which helps a bit

Did you just say that Microsoft actually went and did something right 
for a change? As in publishing specs I mean.

*Stands in awe*

:)

// Stefan


