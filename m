Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277306AbRJEERy>; Fri, 5 Oct 2001 00:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277307AbRJEERn>; Fri, 5 Oct 2001 00:17:43 -0400
Received: from femail26.sdc1.sfba.home.com ([24.254.60.16]:2992 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277306AbRJEERf>; Fri, 5 Oct 2001 00:17:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <adam.keys@engr.smu.edu>
Reply-To: adam.keys@HOTARD.engr.smu.edu
To: linux-kernel@vger.kernel.org
Subject: Development Setups
Date: Thu, 4 Oct 2001 23:20:06 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a budding kernel hacker looking to cut my teeth, I've become curious about 
what types of setups people hack the kernel with.  I am very interested in 
descriptions of the computers you hack the kernel with and their use patterns.

I was thinking of starting with a modern machine for developing/compiling on, 
and then older machine(s) for testing.  This way I would not risk losing data 
if I oops or somesuch.  Alternately, is there a common practice of using lilo 
to create development and testing kernel command lines?  Is this a useful 
thing to do or is it too much of brain drain to switch between hacking and 
testing mindsets?

Instead of having separate machines,  there is the possibility of using the 
Usermode port.  As I understand it this lags behind the -ac and linus kernels 
so it would be hard to test things like the new VM's.  Usermode would not be 
suitable for driver development either.  Again, thoughts on this mode of 
development?

Which brings me to the final question.  Is there any reason to choose 
architecture A over architecture B for any reason besides arch-specific 
development in the kernel or for device drivers?

AKK

-- 
Adam K. Keys
<adam.keys@HOTARD.engr.smu.edu> (Remove the HOTARD to email me)
