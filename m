Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbTHFQ2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270219AbTHFQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:28:18 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:3781 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S270022AbTHFQ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:27:34 -0400
Message-ID: <3F312C65.9000201@nortelnetworks.com>
Date: Wed, 06 Aug 2003 12:27:17 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: Werner Almesberger <werner@almesberger.net>, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <m1fzkiwnru.fsf@frodo.biederman.org> <20030804162433.L5798@almesberger.net> <m1u18wuinm.fsf@frodo.biederman.org> <20030806021304.E5798@almesberger.net> <m1llu7ushr.fsf@frodo.biederman.org> <20030806103758.H5798@almesberger.net> <20030806105830.B26920@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> On Wed, Aug 06, 2003 at 10:37:58AM -0300, Werner Almesberger wrote:
> 
>>Eric W. Biederman wrote:
>>
>>>to keep your latency down.  Do any ethernet switches do cut-through?
>>>
>>According to Google, many at least claim to do this.
>>
> 
> Do you have any references for this claim?  I have never seen one that
> panned out (at least not since the high-end-10mbps days).
> 
> Just to be clear, I am asking for an example of a Gigabit Ethernet
> switch that supports cut-through switching.  I contend that there is no
> such beast commercially available today.
> 
> (It would be even more interesting if it could switch 9000-octet jumbo
> frames, too.)

A few seconds of googling shows that these claim it:
http://www.blackbox.com.mx/products/pdf/europdf/81055.pdf
http://www.directdial.com/dd2/images/pdf_specsheet/J4119AABA.pdf

I'm sure there are others...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

