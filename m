Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTCETAc>; Wed, 5 Mar 2003 14:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTCETAb>; Wed, 5 Mar 2003 14:00:31 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:39079 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S267472AbTCES75>; Wed, 5 Mar 2003 13:59:57 -0500
Message-ID: <3E664BB8.6010905@myrealbox.com>
Date: Wed, 05 Mar 2003 11:10:48 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre5-ac1:  Broadcom gigabit ethernet quirk introduced
References: <fa.fl0gpjr.t3u29h@ifi.uio.no> <fa.f079mas.1qlo10a@ifi.uio.no>
In-Reply-To: <fa.f079mas.1qlo10a@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Wed, Mar 05, 2003 at 09:37:09AM -0800, walt wrote:
> 
>>Hi Alan,
>>
>>I have an ASUS A7VX8 motherboard with built-in Broadcom gigabit
>>ethernet chip which has been working perfectly right up through
>>-pre4-ac7 and now has developed a strange problem starting with
>>-pre5-ac1.
> 
> 
> Is this difference present in plain-jane 2.4.21-pre4 versus 2.4.21-pre5?

Hi Jeff,

I compiled a plain -pre5 just for you  ;-)

Yes, the difference apparently has nothing to do with Alan.  And (as
another data point) I tried 2.5.64 and I find exactly the same problem
with the Broadcom chip:  if I do the ifconfig down/up cycle the chip
starts working normally again.  I haven't played with 2.5.x very much
so I can't tell you when the Broadcom problem started there.  If you
have a theory to test, I could compile an older 2.5 if you like.


