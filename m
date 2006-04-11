Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDKLqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDKLqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWDKLqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:46:39 -0400
Received: from spirit.analogic.com ([204.178.40.4]:41735 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750778AbWDKLqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:46:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <Pine.LNX.4.61.0604111329520.928@yvahk01.tjqt.qr>
x-originalarrivaltime: 11 Apr 2006 11:46:37.0943 (UTC) FILETIME=[975CF070:01C65D5D]
Content-class: urn:content-classes:message
Subject: Re: Slow swapon for big (12GB) swap
Date: Tue, 11 Apr 2006 07:46:37 -0400
Message-ID: <Pine.LNX.4.61.0604110739580.29083@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Slow swapon for big (12GB) swap
Thread-Index: AcZdXZdmRLVhmXhVRBKVaxZr9K6WpQ==
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net> <443A0A6F.2040500@aitel.hist.no> <Pine.LNX.4.63.0604101205300.31989@alpha.polcom.net> <Pine.LNX.4.61.0604111329520.928@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Grzegorz Kulewski" <kangur@polcom.net>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2006, Jan Engelhardt wrote:

>>
>> Well - I use it for /var/tmp for compiling packages in Gentoo. Most compiles
>> use < 1MB of it and it is *much* faster that way because immendiate data never
>> touch disk. And the disk stays idle the whole time so can be put to sleep and
>> should live longer.
>>
>
> Spinning the disk up and down more often than a continuously-running disk
> is also a issue.
>
>
> Jan Engelhardt
> --

Yes, a spinning disk gathers no moss! Once a disk is running, the
heads are flying and the shaft remains centered in its bearing
by hydrostatic forces from the film of oil that circulates around
the "Oilite" (sintered bronze) bearings. There is virtually no
wear. It's the startup and shutdown that takes its toll. That's
why there are so may crashed PCs after a power failure at a
large company. The "@*(%^@_*(" disk drive(s) won't start up,
having been running fine for the past five or more years!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
