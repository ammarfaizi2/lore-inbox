Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRJVUXA>; Mon, 22 Oct 2001 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278881AbRJVUWw>; Mon, 22 Oct 2001 16:22:52 -0400
Received: from mail.myrio.com ([63.109.146.2]:59640 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S278880AbRJVUWh>;
	Mon, 22 Oct 2001 16:22:37 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CA7C@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Gregory Ade'" <gkade@bigbrother.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux 2.2.20pre10
Date: Mon, 22 Oct 2001 13:22:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Ade ranted, and I couldn't resist replying:
  
> So, then, just to satisfy my curiosity, how long until users 
> of Linux in
> the U.S.A. will no longer be allowed to download new kernels?

If (hopefully not when!) the SSSCA passes.  Personally, I'm making 
plans to get out of the US if that happens.

> After all, all it would really take for one of us to find out what was
> fixed is to download this patch and go through it line by line, and
> examine the context of the changes.
> Or are we no longer allowed to look at the sources either?

Of course you can look at the sources.  So ** YOU ** can go through 
the patches, figure out exactly what the security flaws were, create
a detailed description, and post it on a web page or on this list.

Then ** YOU ** are the one who might get sued under the DMCA.  
Why should Alan take the risk? 

> I'm really confused by this gesture.  You're talking about 

I don't think it is primarily a gesture.  Obviously Alan is taking
a somewhat extreme position, probably (partly) to make a point, but 
there are REAL issues here.  (IANAL either, of course.)

To spell it out:

1. The security flaws were in userid and other kernel subsystems.

2. These kernel systems could be used to protect copyrighted data - 
   for example, perhaps some on-line music company uses Linux
   servers to store the music.

3. Instructions on how to check for (i.e. exploit) the flaw may
   constitute an illegal copy control circumvention device.
   Why?  Well, perhaps if you know the details, you could use 
   them to hack on-line music servers, and download music for 
   free, or without the DRM locks on it.  It really isn't 
   difficult to come up with a plausible example.

4. Presenting detailed information like this, together with sample
   code, is basically what Dimitri Skylarov was arrested for.

4b.  You are not safe even if you never visit the US.  

5. Dimitry is still awaiting trial and faces (at worst) ~20 years
   in jail and tens of thousands of dollars in fines, merely for
   explaining how lousy the security is on some software intended
   to protect copyrighted content.

6. Therefore, as I see it, Alan wisely is avoiding even coming 
   close to that.

Do you really have a problem with that?  I think it's very prudent.

The source code or patch itself is a FIX, it cannot be construed 
as a circumvention device.  (compare to information about the holes,
which includes shell script for sample exploits, etc.)
 
> I guess I was wrong about the Linux kernel being Open Source 
> and freely available and distributable.

Calm down, you are getting your knickers in a knot over something
that is not Alan's fault.  

Torrey Hoffman


