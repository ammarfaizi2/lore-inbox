Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbSLRWPz>; Wed, 18 Dec 2002 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267404AbSLRWOM>; Wed, 18 Dec 2002 17:14:12 -0500
Received: from conductor.synapse.net ([199.84.54.18]:50961 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S267395AbSLRWLb> convert rfc822-to-8bit; Wed, 18 Dec 2002 17:11:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: John Bradford <john@bradfords.org.uk>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133  Promise ctrlr, or...
Date: Wed, 18 Dec 2002 17:18:26 -0500
User-Agent: KMail/1.4.1
Cc: andre@linux-ide.org, manish@Zambeel.com, linux-kernel@vger.kernel.org
References: <200212182204.gBIM48uD000332@darkstar.example.net>
In-Reply-To: <200212182204.gBIM48uD000332@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212181718.26407.marvin@synapse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd flashed the BIOS awhile ago, and it hasn't been updated since ( that 
I know of, it's an A7V133, so flashing it this year ...

Ah, yes, the scum who maintain the Asus websites don't allow secure 
browser access, so .. switching to Mozilla w/ scripting...
yes, they updated it to deal with the Thoroughbred, .. blockheads don't 
have the flash-util available on the site?
... right, have to go back to download start page..
what drugged official designed the "flow" of this site?

right, I'll check this, possibly flash the 'board, and get back to you.. 
tomorrow, because I've been up too long and am now fried, and I'm not 
flashing BIOS or going through all the setup again while I'm this 
fritzed.

I /hope/ this fixes it, but am not betting anything on it...

... and by the way .. thanks, people, eh?


On Wed 18 December, 2002 17:04, John Bradford wrote:
>> The BIOS is written to prevent one from choosing SCSI-boot and not
>> Promise-boot while the Promise-BIOS is enabled, so I'd disabled it.
>> ... when I re-enabled the Promise-BIOS, the problem disappeared.
>
>Have you checked for a possible BIOS update that might let you leave
>the BIOS enabled, and boot from another device, or alternatively
>initialise the chipset even though the BIOS is disabled?
>
>(I know it sounds odd to look for a BIOS update for an instance when
>you want the BIOS disabled, but, for example, on my Adaptec SCSI
>adaptor, disabling the BIOS means that it doesn't reserve address
>space, but it still initialises the devices.)
>
>I actually have a Promise card that I'm not using.  I bought it, but
>never used it, (I did use the IDE cable that came with it - that must
>have worked out to be the most expensive IDE cable in the world, at
>about 40 quid :-) :-) :-)).
>
>John.

-- 
http://www.drawright.com/
 - "The New Drawing on the Right Side of the Brain" ( Betty Edwards, 
check "Theory", "Gallery", and "Exercises" )
http://www.ldonline.org/ld_indepth/iep/seven_habits.html
 - "The 7 Habits of Highly Effective People" ( this site is same 
principles as Covey's book )
http://www.eiconsortium.org/research/ei_theory_performance.htm
 - "Working With Emotional Intelligence" ( Goleman: this link is 
/revised/ theory, "Working. . . " is practical )
http://www.leadershipnow.com/leadershop/1978-5.html
 - Corps Business: The 30 /Management Principles/ of the U.S. Marines ( 
David Freedman )
