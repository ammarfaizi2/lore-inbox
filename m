Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTDYMt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTDYMt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:49:29 -0400
Received: from snoopy.pacific.net.au ([61.8.0.36]:5828 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id S263945AbTDYMt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:49:27 -0400
From: "David Luyer" <david@luyer.net>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Daniel Phillips'" <phillips@arcor.de>
Cc: "'Jamie Lokier'" <jamie@shareable.org>,
       "'Downing, Thomas'" <Thomas.Downing@ipc.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Flame Linus to a crisp!
Date: Fri, 25 Apr 2003 23:01:21 +1000
Message-ID: <089201c30b2a$c58c3ce0$46943ecb@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <1051224351.4005.87.camel@dhcp22.swansea.linux.org.uk>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Iau, 2003-04-24 at 22:42, Daniel Phillips wrote:
> > A more mundane goal would be to prevent the 3D driver from 
> > letting you see through polygons that are supposed to be
> > opaque.
> 
> In the MUD world we solved that by not telling anyone about 
> objects they can't see. 

The problem is not solved in the MUD world particularly well.

Sure, you can not transmit the location of other players, but
the client software (eg. zmud) can still give the client an
advantage over the "innocent telnet using client", by doing
things like keeping a map and tracking your current location
(and even using point-and-click to go to any previously seen
location).

Discworld as an example had an area with left,right,back,forward
directions which zmud was later enhanced to handle.  So to
make things a little harder they changed descriptions a little
when "anomolies" appeared so automated "return to previous
point" procedures would walk through the anomoly and get warped
into a reality with hard to determine rules (directions
left,right,forward,back, but if you go left four times you don't
end up where you started).

And there are other problems from the MUD world that have
parallels in 3D online gaming... triggers, for example.

Even colourization of MUD text by something like TF is
equivalent to 3D drivers doing some kind of enhancement
on distant objects (showing you the distant player movement
that would otherwise be barely percievable).

I'm not holding my breath for the first MUD to use DRM to
ensure the end-user is directly connected to a keyboard
with no triggers, mapping, colourization, etc in between
though :-)

Even if such a setup was possible, and say the keyboard was
even a "signed device", you could still setup a mechanical
device to override the keys for you and some OCR software on
a second PC reading the screen's display and displaying the
colourized version, processing triggers, generating maps,
etc.  There is sufficient technology available these days
that DRM would be insufficient to even protect a MUD from
the most basic forms of cheating.

David.

