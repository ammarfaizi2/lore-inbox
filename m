Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUAFODG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 09:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUAFODG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 09:03:06 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:28577 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263228AbUAFOC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 09:02:56 -0500
Message-ID: <3FFABFB7.2050700@grupopie.com>
Date: Tue, 06 Jan 2004 14:01:27 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird problems with printer using USB
References: <20040105192430.GA15884@DervishD> <20040105194537.GJ22177@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Mon, Jan 05, 2004 at 08:24:30PM +0100, DervishD wrote:
> 
>>    ....
>>    I'm using kernel 2.4.21, if this matters...
>>
> 
> It does.  I'd recommend trying 2.4.23-pre3, as it had a usb printer
> driver update in it.
> 
> Or 2.6.0, that also should be better.

I submitted a patch against kernel 2.6.0 to correct a bug in the usblp write 
function. It is probably not related to your problem, but if using a 2.6.0 
kernel doesn't solve your problem, you can try it anyway to see if it helps.

-- 
Paulo Marques -  www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

