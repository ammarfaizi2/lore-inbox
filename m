Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVLHLEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVLHLEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 06:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVLHLEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 06:04:42 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:25354 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751144AbVLHLEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 06:04:41 -0500
In-Reply-To: <5a2cf1f60512080142j175bc79eq1b95182d22268b6b@mail.gmail.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org> <loom.20051206T094816-40@post.gmane.org> <20051206104652.GB3354@favonius> <loom.20051206T173458-358@post.gmane.org> <20051207141720.GA533@kvack.org> <5a2cf1f60512080142j175bc79eq1b95182d22268b6b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B232B187-7141-427B-90BF-AAC2C0A8809B@oxley.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Dirk Steuwer <dirk@steuwer.de>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: Runs with Linux (tm)
Date: Thu, 8 Dec 2005 11:04:36 +0000
To: jerome lacoste <jerome.lacoste@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Dec 2005, at 09:42, jerome lacoste wrote:
>
> I've read that thread with interest and would like to share some of  
> my thoughts.
>
> What are the issues with a "run with Linux" sticker?
>
> - supported by who? kernel.org? a distribution? the vendor?
>

Supported financially by:
OSDL? A generous donor? IBM? Distros?


> - accredited by who? the entity that supports? an external entity?
>

The technical accreditation would have to be based on the existing  
expertise of the kernel maintainers.

Administration handled by a new Independent not-for-profit body with  
initial funding from the bodies mentioned above.
On going funding provided by revenue from anyone who wants to use the  
logo without having provided an open-source driver in 'payment'.


> - support which features? If the in-kernel driver contains the bare
> minimum number of features, but no support for the advanced features,
> what does the support claim mean? E.g. with all the OSS/ALSA, APM/ACPI
> debates, I wonder what happens whenever a hardware is 'half'
> supported.
>

The accreditation, by kernel maintainers, would be based on the fact  
that the driver provides full support for the features of the hardware.


> - which Linux version? Some people mention restricting support to a
> particular linux version or time periods. I find this not very
> practical. How can you guarantee that in the next 2 years (or even 6
> months)? With non stable API/ABI, how do you want to sell the idea of
> unknown unforecastable development costs to the hardware maker?
>
> - I still see people saying supported on "Linux 9.1" (aka Red Hat/Suse
> or whatever)...
>

Maybe the OEM cannot get accreditation for a new device if they have  
any accredited devices which are 'broken'


> - it requires the manufacturer to care about putting the sticker in
> place. If they start to advertise support, they will have more costs,
> even if the support is handled by an external entity.
>

The purpose of the logo is to build customer demand for hardware  
which is accredited and therefore has the benefits of open source  
drivers which will be maintained.
Once the logo gains mind share there will be a competitive advantage  
for the OEMs who use it.
Therefore they will be willing to bear some costs.


> - what happens when a different revision of the 'same' hardware is not
> supported anymore? It happened with one my webcam.
>

As above.
(Maybe the OEM cannot get accreditation for a new device if they have  
any accredited devices which are 'broken')



> - how does that work when online? You will have a particular hardware
> saying "Runs With Linux" and another one fully supported by the maker,
> or fully unsupported use-ndiswrapper-like saying "Runs On Linux" or
> "Works on Linux". How does the sticker help me to decide?
>

The primary requiremnet to gain the logo is that there is an open  
source driver (merged in the kernel tree).
The logo allows people to tell the difference between OEMs who claim  
compatibility because they use ndiswrapper and those who actually  
have a proper kernel driver.

>
> Because of all these reasons, I don't think we will ever have half of
> the really supported hardware even display the sticker. What does that
> mean for me as a user? I will still need to search for information
> about the other part.
>
> How to identify the other part?
>

The solution depends on build the logo 'brand' so that different  
players in the linux world want to use it .
This will happen in the following manner:
  (as described in this thread http://lkml.org/lkml/2005/12/7/391)
>
>> Why will this work? Here is how I see it developing in the server  
>> market:
>>
>> 1. The logo will be launched along with a campaign to explain to  
>> technical users that (a) open source drivers are better quality,  
>> (b) that binary drivers threaten the future of the Linux ecosystem.
>>
>> 2. Any company which manufactures equipment with open source  
>> drivers already available will have the logo granted for their  
>> current equipment.
>>      This means that right from the outset it will be possible to  
>> put together a system which is wholly conformant, i.e. the entire  
>> PC is eligible to carry the logo.
>> 3. Certain small system builders will get on board.
>> 4. Obviously, everyone on LKML will only buy/recommend hardware  
>> which carries "the mark of the penguin". As will geeks the world  
>> over.
>> 5. One of the distros will decide that their "Supported Hardware"  
>> list will only feature items with the logo.
>> 6. Medium sized system builders, maybe "partners" of the distro  
>> will begin to ship systems that fully conform.
>> 7. All the supporters above will be using the the new Open Source  
>> Graphics hardware from www.opengraphics.org. (Important later)
>> 8. Corporate or government buyers will by now become aware of the  
>> value of buying certified equipment.



> I'd rather want to know this information from the community. The
> community, in help with the distribution vendors, should come up with
> a big database that contains all this information. I don't want to go
> on the ALSA web site to check if my sound card is supported, then on
> the SATA one for my disk controller, then on linux-usb etc...
>
> I want tools to help us feed that database, like the Ubuntu Device
> Database client. But I want that at the Linux scale not the
> distribution one.
> * The client software would be used to report functional state of
> hardware elements or access information about a particular hardware
> present on the machine.
> * There should be an easy way to have a Live distro with the latest
> kernel that contains the minimal set of programs required to run this
> Hardware Database client.

With a logo a PC vendor such as Dell can stick the logo on their PCs  
if and only if every component in the machine is certified.  
(Including motherboard, on-board graphics, on-boad-sound, on-board  
raid etc. etc.)

This means you or I don't have to try to find out the exact machine  
specification from Dell and then individually check each part against  
the hardware database.

regards,
Felix


