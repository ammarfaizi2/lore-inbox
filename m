Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSKZM0x>; Tue, 26 Nov 2002 07:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSKZM0x>; Tue, 26 Nov 2002 07:26:53 -0500
Received: from gaea.projecticarus.com ([195.10.228.71]:51105 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S264683AbSKZM0w>; Tue, 26 Nov 2002 07:26:52 -0500
Message-ID: <3DE36A10.4050506@walrond.org>
Date: Tue, 26 Nov 2002 12:33:20 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trog@wincom.net
CC: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
References: <3de27d7d.59a8.0@wincom.net>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attitude of *some* people (even those considered senior) in this and 
other mailing lists is down right shameful.

Anybody who are genuinely trying to help, contribute or just get 
involved all too often have their efforts publicly belittled.

Polite criticism and guidance is always the better option and encourages 
people to join in rather than frightening them off.

Arrogance (Ar"ro*gance) (#), n.
[F., fr. L. arrogantia, fr. arrogans. See Arrogant.]

The act or habit of arrogating, or making undue claims in an overbearing 
manner; that species of pride which consists in exorbitant claims of 
rank, dignity, estimation, or power, or which exalts the worth or 
importance of the person to an undue degree; proud contempt of others; 
lordliness; haughtiness; self-assumption; presumption.


> 
>>>This is the linux-kernel list. Nothing you said has anything
>>>to do with the linux-kernel. 
>>
> 
> Oh really Richard?
> 
> Re-read the message. 
> 
> Point #1 has to do with kernel configuration; ie, "cd /usr/src/linux ; make
> xconfig" and the choices made thereafter. I want something like "make modelnumberconfig"
> that abstracts away most of the lower level items based on what low-level stuff
> is associated with which chunk of hardware.*
> 
> I'm pretty sure any time you're invoking the kernel Makefile that you're discussing
> a "linux kernel issue"
> 
> Point #2 has to do with the messages that drivers, modules, and other bits of
> kernel code print to the dmesg data store wrt how they are currently set up
> - in other words, kernel state information. The last time I checked, these messages
> were contained inside the kernel source - I remember looking through "ide.c"
> looking to see what the "idebus=xx" parameter really controlled, and if it had
> anything to do with the ATAxx values (as it turns out, it does not, although
> my Googling indicates that this seems to be a common misconception)
> 
> So this, as well, is entirely appropriate material for linux-kernel.
> 
> Point #3 has to do with the issues in publishing where what hardware is supported
> in what kernel version, and where drivers not currently contained in the vanilla
> kernel are located. Put another way, point #3 is about locating the output of
> the work of people "employed" on linux-kernel, and so is also entirely appropriate.
> 
> 
> That you are knee-jerk flaming a legitimate message that is entirely on-topic
> indicates that you didn't actually read the message, and instead fixated on
> one or two statements contained within itand made assumptions from there. That
> doesn't seem like good kernel developer practice - perhaps you were looking
> for Slashdot?
> 
> -------------
> * I saw one response from a gentleman who indicated that the low-level hardware
> associated with a given "high-level" part number may well change during the
> life of the part, and that this poses difficulty. I agree. I also think that
> "perfect is the enemy of good enough" and that a case where you can abstract
> away the underlying complexity for 90% of the people is probably good enough;
> especially if there is some sort of feedback mechanism whereby running changes
> to "high level" part numbers (and the related "low-level" kernel module associations)
> can be updated in short order.
> 
> For the gentleman who posted examples of ATA dmesg output that duplicated very
> nearly what I was asking for, mine didn't do that. I'll take that (very specific)
> issue up in a later thread when I have access to the dmesg output from my machine.
> 
> 
> DG
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


