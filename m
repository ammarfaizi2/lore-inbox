Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRBTUuL>; Tue, 20 Feb 2001 15:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRBTUuB>; Tue, 20 Feb 2001 15:50:01 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:28679 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S129563AbRBTUt7>; Tue, 20 Feb 2001 15:49:59 -0500
Message-ID: <3A92D967.473E67CF@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Adaptive Domain Environment for Operating Systems
In-Reply-To: <3A8C029B.3B2C1AD3@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Feb 2001 15:49:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've set up a sourceforge project for Adeos:
http://www.sourceforge.net/projects/adeos

There's also a development mailing list which can be found here:
http://lists.sourceforge.net/lists/listinfo/adeos-devel

There's also some code here:
ftp://ftp.opersys.com/pub/Adeos/Adeos.tgz

Be aware that this code will certainly crash your machine. It
is an attempt to drive Linux into ring-one, but it is not
functionnal. You've been warned.

Feel free to join in the discussion.

Best regards,

Karim Yaghmour

Karim Yaghmour wrote:
> 
> I've put up the following (white) papers out for general discussion:
> -Adaptive Domain Environment for Operating Systems (Adeos)
> -Building a Real-Time Operating System on top of the Adeos
> 
> The first paper discusses the design and implementation of a nano-kernel-
> like facility that may be used to take control away from an unmodified
> running linux on ix86 for further uses including (but not limited to):
> -patch-less kernel debuggers/probers
> -running multiple general purpose OSes on the same hardware,
> -OS development
> -etc.
> 
> As the first item suggests, this may be of interest to some on
> this list as kernel debuggers have been a rather pointy subject...
> 
> The second document discusses a special case usage of Adeos that
> enables a real-time-bound kernel to co-exist with Linux on top of
> Adeos.
> 
> The documents can be found here:
> http://www.opersys.com/adeos/index.html
> 
> I've requested a project entry for Adeos on sourceforge and will
> update the project's home page as soon as everything is set up.
> 
> In the mean time, anyone interested to participate in the project
> or that has pertinent information regarding the implementation, or
> its feasibility or lack of, as described in the Adeos document is
> welcomed to contact me.
> 
> KEEP IN MIND that the documents are only a suggested method of
> doing things designed to stimulate discussion. There isn't one
> line of functionnal code out there (yet).
> 
> Best regards,
> 
> Karim
> 

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
