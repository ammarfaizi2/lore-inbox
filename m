Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266306AbRGFIq1>; Fri, 6 Jul 2001 04:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266304AbRGFIqH>; Fri, 6 Jul 2001 04:46:07 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:48139 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S266303AbRGFIqB>; Fri, 6 Jul 2001 04:46:01 -0400
Message-ID: <3B457AA3.D74E1FCE@idb.hist.no>
Date: Fri, 06 Jul 2001 10:45:23 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu,
        alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107050810400.22053-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 
> You would never even know the difference. You'd do a "make bzImage", and
> the default filesystem would just be embedded into the image. By default
> it probably doesn't need to do much - although things like the BIOS DPMI
> scan etc would surely be good to get rid of.
> 
> Why complain about that?

I am convinced.  I misunderstood, thinking there was a big change just
for
ACPI which I and many others don't use.  Thanks for clearing things up.

Helge Hafting
