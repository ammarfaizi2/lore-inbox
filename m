Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbTGDDtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbTGDDtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:49:04 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:26268 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S265742AbTGDDtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:49:02 -0400
Message-ID: <3F04FD21.4090709@blue-labs.org>
Date: Fri, 04 Jul 2003 00:05:53 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: laptop w/ external keyboard misprint FYI
References: <3EFC7716.8050804@blue-labs.org> <20030703090317.A24322@ucw.cz>
In-Reply-To: <20030703090317.A24322@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well...I'm typing on the keyboard right now :)

Any info I can give that can help?

David

Vojtech Pavlik wrote:

>On Fri, Jun 27, 2003 at 12:55:50PM -0400, David Ford wrote:
>
>  
>
>>Kernel 2.5.73, first time I've used an external keyboard
>>
>>When I plug my external Logitech keyboard into my laptop, (shared 
>>keyboard/mouse port), dmesg output indicates a generic mouse was 
>>attached instead of a keyboard.  The keyboard works, it's just the dmesg 
>>info that's inaccurate.
>>
>>Keyboard plugged in:
>>input: PS/2 Generic Mouse on isa0060/serio1
>>
>>Mouse plugged in:
>>input: PS/2 Logitech Mouse on isa0060/serio1
>>    
>>
>
>Honestly, I don't think this is possible. If your keyboard is detected
>as a mouse, it cannot work a a keyboard. Though maybe your
>keyboard/mouse controller BIOS may be playing tricks on us.
>
>  
>

