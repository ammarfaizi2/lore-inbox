Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278046AbRKLJdm>; Mon, 12 Nov 2001 04:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280088AbRKLJdc>; Mon, 12 Nov 2001 04:33:32 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:30340 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278046AbRKLJdU>; Mon, 12 Nov 2001 04:33:20 -0500
Date: Mon, 12 Nov 2001 09:33:18 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Bernd Petrovitsch <bernd@gams.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Very-OT] Re: Nazi kernels 
In-Reply-To: <200111120913.fAC9D7C20810@frodo.gams.co.at>
Message-ID: <Pine.SOL.3.96.1011112093015.27188A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Bernd Petrovitsch wrote:

> In message <Pine.SOL.3.96.1011111120107.21134C-100000@libra.cus.cam.ac.uk>, Ant
> on Altaparmakov wrote:
> >I think we ought to do the same with closed source drivers. It's true
> >after all... The whole point of tainting the kernel is so we can just yell
> >at users to go and bug the vendor. So the modprobe executable could warn
> >the user "hey, you are loading a binary only module, it can break the
> >system, are you sure?". If the module is autoloaded we don't do jumping
> >through hoops asking questions so the systen runs smoothly.
> 
> Un*x admins know what they are doing by definition. So this is not 
> necessary.
> Now you see what some Seattle area company think of admins of theirs
> (so called) OS.

Admins know what they are doing. Your average person trying Linux for the
first time doesn't... You are forgetting that Linux is actually becoming
useful as a desktop OS and a wider audience is starting to use it.

But considering you already get a warning message on insertion that will
do fine, no need to ask are you sure. GUI configuration tools can always
do the "are you sure bit" if they want to. 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

