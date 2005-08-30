Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVH3Rpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVH3Rpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVH3Rpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:45:30 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:8460 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932235AbVH3Rp3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:45:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <194B303F2F7B534594F2AB2D87269D9F06EFAE48@orsmsx408>
References: <194B303F2F7B534594F2AB2D87269D9F06EFAE48@orsmsx408>
X-OriginalArrivalTime: 30 Aug 2005 17:45:22.0188 (UTC) FILETIME=[984814C0:01C5AD8A]
Content-class: urn:content-classes:message
Subject: RE: KLive: Linux Kernel Live Usage Monitor
Date: Tue, 30 Aug 2005 13:44:28 -0400
Message-ID: <Pine.LNX.4.61.0508301339570.4665@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KLive: Linux Kernel Live Usage Monitor
Thread-Index: AcWtiphRL1WwzHQFTXOQSJlt35LFdg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
Cc: "Andrea Arcangeli" <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Aug 2005, Wilkerson, Bryan P wrote:

>
>
> On Tue, Aug 30, 2005 at 10:01:21AM +0200, Sven Ladegast wrote:
>> The idea isn't bad but lots of people could think that this is some
> kind
>> of home-phoning or spy software. I guess lots of people would turn
> this
>> feature off...and of course you can't enable it by default. But
> combined
>> with an automatic oops/panic/bug-report this would be _very_ useful I
>> think.
>
> I think this is useful and would personally participate if it were a
> config tweak.  There are a couple of issues that come to mind.
>
> 1. Possibly paranoia, but given the apparent numbers of people with
> malicious intent on the Internet and knowing that there are some
> financially motivated to make Linux kernel developers over confident in
> they're work, I'm not sure I'd trust or use the data unless it was
> somehow authenticated.
>
> 2. Some of us sit behind corporate firewalls and proxies that have
> oppressive rules that would have made Stalin proud.  The solution must
> be proxy aware and if it used HTTP, even better because it's more likely
> to work anywhere.  The proxy settings could also be a .config thing.
>
> 3. Again security; I haven't cleared this with my corporate superiors
> but I'm not sure they'll like the fact that anyone could intercept the
> data and compute how many people in the company are running Linux test
> kernels.  I know this almost sounds anti-open but we're breaking them in
> slowly to the model and I don't think they are ready for this one just
> yet. :)
>
> -bryan
> -

The beginnings of "Magic Lantern" and "Carnivore"? Good, now just
use port 25 because everybody has port 25 open ..... Just like
Microsnitch^M^M^M^M^Msoft.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
