Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWAZSXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWAZSXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWAZSXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:23:50 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:56188 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932394AbWAZSXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:23:49 -0500
Date: Thu, 26 Jan 2006 13:23:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-reply-to: <43D8D69F.nailE2XAJ2XIA@burner>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601261323.47903.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
 <43D8D69F.nailE2XAJ2XIA@burner>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 09:03, Joerg Schilling wrote:
>jerome lacoste <jerome.lacoste@gmail.com> wrote:
>> As a Linux user, the only reason I do cdrecord -scanbus is to comply
>> to the cdrecord way of doing likes. I don't personally like it.
>>
>> I'd rather use /dev/cdrw, in a machine independent way, as in:
>>
>>   ssh user@host cdrecord dev=/dev/cdrw /path/to/file.iso
>
>On the vast majority of OS this does not work.
>
>Jörg

But from the Joe SixPack user standpoint, he should be able to click to 
launch the program, and click on the file he wants to put on the cd.  
The leds on the face of the drive should come on and the cd should come 
out.

All he knows is its that thing with the coffee holder sticking out of 
the front of the box that he had to remove his beer from to put in the 
blank cd & he doesn't care, *as long as it works*.

You have been offered a way to simplify your interface by many many 
lines of code, yet you resist, insisting that all other platforms do it 
your way, when in fact they don't either according to several lengthy 
threads I've now read on this subject.  There are far more winderz 
users than linux so far, and the winderz interface, except for the 
actual names used (drive F, what a strange moniker that is) is no more 
nor less complex, and both _just work_ if properly used.  A simple 
case: statement should handle it all.  So whats the problem?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
