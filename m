Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbTAHFLk>; Wed, 8 Jan 2003 00:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbTAHFLk>; Wed, 8 Jan 2003 00:11:40 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21517
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267753AbTAHFLh>; Wed, 8 Jan 2003 00:11:37 -0500
Date: Tue, 7 Jan 2003 21:18:49 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Commentary Summary:
Message-ID: <Pine.LNX.4.10.10301071844230.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What we have seen is a lot of slide of hand tricks to try and force all
the hardware and software vendors to open source and give it all away.

This is not going to happen.

I tried it and had some success, but it cost me lots of money, time, legal
hassles, but now that the chipsets are modular what will happen?

The latest tricks in our bag:
	GPL_ONLY
	GPL_ONLY + restrictive kernel system calls.
	Rants about derived works.

Is linux the sum of the drivers ?
If all the drivers were gone, what would be left?
Is linux the a derived work from the sum of the drivers?
Is the the source code not that manual to the API?
	"Use the Source Luke!"

Is linux going to invoke the DMCA to prevent usage?
What will happen if any one of the developers trying to enforce copyright
under GPL, loses?

Now of to winners and losers:

Linux 2.6/3.0 kernel ships.  One distribution present today or created in
the future because of politics or market forces, decides to disable the
GPL_ONLY as to allow binary modules to use all of the kernel services
unrestricted.  The include all the source code and patches and follow all
the rules that each one is doing today.

Subtext: If GPL_ONLY is such a big issue for the distributions who employ
and rightfully own the works released, ship their products in this mode?
Of course they do not need to ship the patch, because it is in the kernel
tree shipped.  This would add complexity to the enduser, to undo such a
deed.  Would the customer switch distributions?

The subtext above describes why the GPL_ONLY will fail.
Remember, under GPL none of us can add restrictions to prevent people from
changing the content of the files redistributed.  So it is a given it will
fail, once market forces are applied.

Now move into the embedded appliance space.

This will surely collapse into a black hole if they do not remove the
"GPL_ONLY" properties in the future stable release.  So again market
forces are going to undo all the work everyone has tried to enforce like
this was a closed society of developers, similar to Redmond.

Now back to the issue of copyright enforcement since GPL is some what
removed from the issue at the enduser level.

Copyright only protects the actual document and not the content.
Recall my whining about "Vojtech Pavlik <vojtech@suse.cz>", during the
time when "Martin D." was running the show, and everyone jumped on me and
called me a fool for complaining about the file replacement issue?

The reality is that "Vojtech" complied with everything about Copyright
Law, and I had no case at all.  What "Vojtech" did was to read my work and
created something new from the idea inside the document.  For the most
part it worked just fine and functioned with the same behavior.  One
difference is is I lost my copyright on the file, but the "IDEAS" were
transferred to a new file.

Oh and Vojtech, I own you a huge apology for being rude and ugly to you
over that entire series of events.  If you can improve on the work, by all
means you should, and please do.  I will not can, nor would I stop or
hinder progress again.

Now jump back to the so called "unpublished API", again.

Using the example above between "Vojtech" and myself, if anyone was to
create a full snapshot and create a new work(s) by extracting all the
ideas in the headers into a new set, nothing GPL or Copyright can do to
stop them.  What was done is to extract the ideas, not the actual
protected work.

Moving forward with this new snapshot of the API to Linux which is not
subject to any license restrictions or copyright, like it or not that is
the fact!  What does this mean in other cases?  Could HURD extract all the
IDEA's from Linux and make it extinct?  Who knows, but I do know that
should RMS be successfull, that binary modules and freedom are gone.
Since the IDEAS are transformed into a new work, assigned to FSF, oh it
scares me to go further.  This could be a reality.

Here comes the boundary nobody wanted to find, except me!
Finding it may make it impossible to use linux for any business model.
Any model with IP or whatever you call it locked into "binary object".

Subtext: "binary object" and not a binary module.

For ease, lets make the new snapshot API "headers" licensed under LGPL.

I will stop for now as I am tired.

However this clearly explains how one can use the kernel API for a
snapshot, but the pain involved is huge.

I am not into this much pain, period.

Flame me if you want, I do not care.
Hate me if you want, I do not care.
Kick me out again, I do not care.

However, each of us should care and think about the above.

Regards,

Andre Hedrick
LAD Storage Consulting Group






