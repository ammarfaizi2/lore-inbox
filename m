Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWBSXgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWBSXgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWBSXge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:36:34 -0500
Received: from lucidpixels.com ([66.45.37.187]:54149 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932414AbWBSXgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:36:23 -0500
Date: Sun, 19 Feb 2006 18:36:22 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
In-Reply-To: <Pine.LNX.4.64.0602191807001.7212@p34>
Message-ID: <Pine.LNX.4.64.0602191835460.7212@p34>
References: <Pine.LNX.4.64.0602191807001.7212@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/usr/src/linux/Documentation//networking/e1000.txt:the issue to 
linux.nics@intel.com.

^^ That e-mail is invalid, someone should make a diff/patch to remove it 
and update it if there is a correct one or just remove it entirely.

Justin.

As of 2.6.15.3 source.


On Sun, 19 Feb 2006, Justin Piszcz wrote:

> Apparently, A-BIT's Intel driver works for some people, but the Linux one 
> causes the machine to crash.  The same is also true if you use the driver 
> from Intel's website.  I was just wondering if there was any discussion on 
> this list concerning this issue?
>
> I have 4 ABIT IC7-G's and this problem only occurs on two of them, which I 
> have disabled the onboard CSA gigabit nic and put in PCI NICS (intel gigabit) 
> with no problems.
>
> It appears there are some serious problems with Intel CSA GIGABIT with this 
> motherboard, just curious to see if anyone out there heard anything about 
> this?
>
> The interesting part is the first page of this thread:
>
> http://forum.abit-usa.com/showthread.php?t=18707
>
> The author has a "death.zip" file, in which if you copy the file over the LAN 
> it causes an instant crash.  He's tried contacting A-Bit, but is it an A-Bit 
> or Intel or Driver problem as it has been "reported" to work with A-Bit's 
> driver.
>
> I believe this post sums up the problems of IC7-G problems:
>
> --
>
> Yeah, can't have it all, can we? I had serious thoughts about RMA-ing my 
> IC7-G last fall, but the 4 week tournaround was a bit too much downtime for 
> my taste. To resolve the noisy mic-input issue, I bought a cheap soundcard. 
> For the onboard CSA, I did nothing. Running at 1GbE, the NIC has worked very 
> well, disregarding the numerous occations it has strangled my system to 
> death, of course.
>
> I feel sorry for you Sydtech, myself and everyone else out there ripping 
> their hair out over the issues of the IC7. We have spent countless hours 
> trying to figure out what's wrong, worrying about a lengthy RMA process and 
> the adherent downtime - which in Sydtech's case just as well might result in 
> a shabby refurbished MB fixing some problems, but adding others. Many of us 
> have simply resorted to buying PCI add-in cards replacing the dysfunctional 
> parts of the IC7.
>
> We have paid the bill for ABIT's engineering shortcomings, not to mention 
> wasting a lot of time and energy. Last spring I was looking for a MB for my 
> new system. I wanted the best and with as many onboard functions as possible 
> so I could have a less crammed case. I read all the reviews for the new i875 
> MB:s, where - for instance - HardOCP praised it, especially it's superiour 
> sound quality (they did not even try the mic-input). Needless to say, I ended 
> up with the expensive IC7-G, "cream of the crop" and bucketsful of headache.
>
> Alright, so add-in cards cramming up our cases seem to be the easiest way to 
> get the subsystems we've already payed for. But what's really infuriating is 
> that ABIT just refuses to address the issues. No helping hand, no suggestions 
> on how to get things right. They just keep ignoring us. Of course they read 
> the forums, they just think keeping things quiet is their best strategy.
>
> Well, anyhow, I have my strategy worked out for future technology 
> acquisitions: I'll NEVER again buy first revision products the minute they 
> come out. I refuse to again be an unpaid beta tester for an ungrateful and 
> unhelpful manufacturer like ABIT. And I will also take reviews with loads of 
> salt.
>
> --
>
> I was wondering if anyone from intel.nics@intel.com could comment on this 
> issue?
>
> Thanks,
>
> Justin.
>
