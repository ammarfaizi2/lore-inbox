Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVCALjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVCALjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVCALjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:39:20 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:20424 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261879AbVCALjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:39:08 -0500
Message-ID: <422454A5.7070206@blue-labs.org>
Date: Tue, 01 Mar 2005 06:40:21 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ian E. Morgan" <imorgan@webcon.ca>
CC: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALPS tapping disabled. WHY?
References: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net> <200502242208.16065.dtor_core@ameritech.net> <20050227075041.GA1722@ucw.cz> <Pine.LNX.4.62.0502281721210.21033@light.int.webcon.net>
In-Reply-To: <Pine.LNX.4.62.0502281721210.21033@light.int.webcon.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would also appreciate the return of good resolution.  Blocky mouse 
startup moves make graphic editing rather difficult.  No mouse movement 
until I have moved my finger a significant distance then the mouse all 
of a sudden jumps a dozen pixels before it "smoothly" glides along.

I would also love to see the sync issues go away. :/  Whatever this 
patch(es) was supposed to accomplish, it introduced some rather 
undesirable side effects.  a) sync issues, b) tapping, c) fine grain 
movements, d) loss of scroll sliding as well (moving your finger along 
the side/bottom of the glidepoint).

Not griping, just providing feedback.

-david

Ian E. Morgan wrote:

> On Sun, 27 Feb 2005, Vojtech Pavlik wrote:
>
>> Also, in my tree currently (and planned for 2.6.12) hardware tapping is
>> enabled again, because double taps don't work otherwise (hardware
>> limitation).
>
>
> You should really try to get that squeezed into 2.6.11 before it is
> released, or else I would anticipate a LOT more people whining about 
> their
> broken touchpads.
>
> Regards,
> Ian Morgan
>
