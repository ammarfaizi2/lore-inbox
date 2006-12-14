Return-Path: <linux-kernel-owner+w=401wt.eu-S932918AbWLNVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbWLNVPr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbWLNVPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:15:47 -0500
Received: from web58907.mail.re1.yahoo.com ([66.196.100.236]:45430 "HELO
	web58907.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932918AbWLNVPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:15:46 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 16:15:46 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Ajx67g3WH2wywX7ZGbWFDrHnAIDYA0J06MIvDJ1tqfnxioFEMfJ+cQ0PeirqFcVnpH+xRdqj8asSime9qIdUaVYEPUbas+Yk35LSMRpZGHfyqSZdxeAiVqlSpdwRghsYhEKWcB12oMk2xEWlAX1jc+1ga/Dd66i9gQWwaSK36bs=;
X-YMail-OSG: ilU_ebkVM1kr826iskXFd2jN3EQXojIupsdu3atq
Date: Thu, 14 Dec 2006 13:09:06 -0800 (PST)
From: Michael ODonald <mcodonald@yahoo.com>
Subject: Abolishing the DMCA (was GPL only modules)
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, gregkh@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <561312.27000.qm@web58907.mail.re1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> DMCA is bad because it puts technical limits over
> the rights expressly granted by copyright law.

The best ways to get rich corporations on our side in fighting the
DMCA is to use the DMCA to hurt their profits. Companies that rely on
binary drivers would have several options:

1) Lobby politicians to repeal the DMCA, thereby allowing the
companies to *internally* circumvent Linux’s GPL-only
pseudo-restriction all they want by simply changing the source code.

2) Release the binary drivers as open source or use their economic
clout to pressure the makers of the binary drivers.

3) Use FOSS-friendly hardware.

I’m sorry, but there’s currently no economic push for repealing the
DMCA; the only people trying to abolish it are idealists who are
easily out-bought by the media cartel. This is our only chance to put
some corporate money muscle behind the otherwise doomed anti-DMCA
movement.

And just to make it clear: Greg’s proposal calls for a soft-DRM that
is by definition easily circumvented – the only thing that prevents
companies from removing it is the blasted DMCA. Once the DMCA is
gone, so will be the soft-DRM.

> So it's ok when we do it, but bad when
> other people do it?

Those "other people" (Tivo/BlueRay/HD-DVD/Zune/PlayStation/Xbox) are
using hard-DRM (aka. Treacherous Computing) where the *hardware*
refuses to run modified code.  By contrast, this proposed
GPL-enforcing mechanism is a soft-DRM that allows anyone with
mediocre coding skills to remove it. A binary module can even get
away with lying about its own license!

Even the current draft of the GPLv3 allows soft-DRM because soft-DRM
is so easily circumvented. The only entities hurt by pseudo-enforcing
the GPL through soft-DRM are the unscrupulous makers of binary
drivers, who are already infringing the GPL. In-house development of
binary-only drivers can still continue as usual: all you have to do
is not distribute the binary.

Let me quote from what Linus said in an article titled "Torvalds says
DRM isn't necessarily bad":

http://news.com.com/Torvalds+says+DRM+isnt+necessarily+bad/2100-7344_3-6034964.html

"""
Torvalds gave some examples of areas where he believes it's
appropriate for ... a computer to run only software versions that
have this digital signature to assure they're authorized. 
A company might want to distribute a Linux version that loads only
kernel modules that have been signed, for example. Or they may want
one that marks the kernel as "tainted" if it loads unsigned modules,
Torvalds said. 
"""

So why do you say it’s ok for Tivo to refuse to run FOSS modules on
their Treacherous platform, but *not* ok for FOSS developers to
uphold their rights? Are sleazy corporations subject to a different
set of laws or morals than us common folk?

No, laws are generally equitable and strive to provide each and every
one of us with the same legal tools. One such tool, the DMCA, has
been used far too often by monopolies to exterminate competition and
imprison consumers. It’s time to give these monopolies a piece of
their own medicine. They either lobby politicians to abolish the DMCA
or they open-source the Linux drivers that they distribute. Now
that’s a fair deal if I ever saw one!

PS: I encourage Greg and all developers who were initially in favor
of enforcing the GPL-only module policy to stand strong on this
important issue.


 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com
