Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTLYPIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 10:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTLYPIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 10:08:42 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:22290 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264310AbTLYPIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 10:08:41 -0500
Message-ID: <3FEAFD76.8010703@amberdata.demon.co.uk>
Date: Thu, 25 Dec 2003 15:08:38 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: handling an oddball PS/2 keyboard
References: <3FEA5044.5090106@amberdata.demon.co.uk> <20031225063936.GA15560@win.tue.nl>
In-Reply-To: <20031225063936.GA15560@win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Thu, Dec 25, 2003 at 02:49:40AM +0000, David Monro wrote:
> 
> 
>>I have a slightly odd PS/2 keyboard which I'm not quite sure of the best 
[..]
> 
> Interesting. I rearranged my scancode data page a bit and added
> your info - see http://www.win.tue.nl/~aeb/linux/kbd/scancodes-6.html
> Are your scancodes identical to those reported by Benjamin Carter?

Almost precisely! The only differences I can see are probably a result
of his being a japanese one; the physical layout is a little different
and I have PF1-PF4 above the numeric keypad rather than the japanese
compose keys. I'll send you a more detailed description for your page.

> 
>>So.. could I get a bunch of people to have a look in 
>>/proc/bus/input/devices, and see what the 'Version' field for their 
[..]
> 
> 
> Yours is the second report I see for ID 0xab85.
[..]
Hmm. I've seen those extended 122 key IBM keyboards, although I _think_
most of the ones I've seen have been the APL variant. I may know someone
who has one, so I'll see if I can get hold of it to test.

Cheers,

	David


