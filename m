Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271668AbRHQPSi>; Fri, 17 Aug 2001 11:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271671AbRHQPS2>; Fri, 17 Aug 2001 11:18:28 -0400
Received: from [65.105.206.211] ([65.105.206.211]:588 "EHLO
	MAIL.confluencenetworks.com") by vger.kernel.org with ESMTP
	id <S271668AbRHQPSK> convert rfc822-to-8bit; Fri, 17 Aug 2001 11:18:10 -0400
Subject: Via usb problems...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 17 Aug 2001 08:17:28 -0700
Message-ID: <71AD71402EB8B04AB30F351C1EE5707C17C845@MAIL.confluencenetworks.com>
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Topic: Via usb problems...
Thread-Index: AcEnMFmR+G6ul91/Rh+xdZ1ET9OQcQ==
From: "Curtis Bridges" <cbridges@confluencenetworks.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me as I am not subscribed to the list. (kernel traffic saves
my inbox)
 
I just recently purchased a MSI 6380 motherboard and have tried several
distributions and USB was not consistently working on any of them -- to
make a long story short, I found the issue on the MSI tech support site
as being a known problem with the VIA chipset that they are using (and a
lot of other Athlon boards are also using).
 
It appears that USB will cut out ever couple of seconds and then work
again for windows users.  When it cuts out for me in linux, it never
comes back again.  I can tell as my mouse lights up (its an optical)
when working and when it cuts out in linux, the light goes out
permanently until I reboot the machine.
 
The work-around for the problem is provided by VIA in the form of some
updated drivers for windows.  It appears to be some sort of usb filter,
possibly for low bandwidth USB peripherals.  I suspect this isn't a
working resolution for most people on this list and I was wondering if
anyone has been working on this in the kernel?  I might be able to
provide some more information if it is needed to diagnose and solve the
problem...
 
Does VIA have any engineers working on linux drivers?
 
Thanks for the assistance,
Curtis Bridges
cbridges@confluencenetworks.com <mailto:cbridges@confluencenetworks.com>

 
 
