Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTJAOzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTJAOzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:55:35 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:59130 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262259AbTJAOzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:55:25 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Krishna Akella <akellak@onid.orst.edu>, Paul Jakma <paul@clubi.ie>
Subject: Re: Can't X be elemenated?
Date: Wed, 1 Oct 2003 09:54:48 -0500
X-Mailer: KMail [version 1.2]
Cc: kartikey bhatt <kartik_me@hotmail.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309301209590.19804-100000@shell>
In-Reply-To: <Pine.LNX.4.44.0309301209590.19804-100000@shell>
MIME-Version: 1.0
Message-Id: <03100109544800.18755@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 14:30, Krishna Akella wrote:
> Definitely, having the kernel support the GUI features is bad idea IMHO.
> but, What X lacks is a _standard_ toolkit, _complete_ widgetset for
> developers.

Obviously you have never programmed an X application. The STANDARD toolkit is
the X intrinsics.

It is complete. Now if you want fancier displays, add the athena widget set.
Or something with more bloat- Motif/Qt/KDE/...

Hell, I even wrote one for a specific application - MUCH faster than any of
the bloated ones on Motif/Qt/KDE... it is even faster than the athena set
because I eliminated everything that didn't apply to my application. It was
also only 10% of the size of any of them.

> We have
> acrobat using Motif distributed along with the reader, xfig "needing"
> preinstalled Motif, Xaw using Athena, Gnome apps using gtk, KDE apps using
> QT... and so on. Moreover, there is no standard interface for
> communication between these apps using myriad toolkits. And all of this is
> a duplication of effort that can be totally avoided.

Yes there is. They ALL work together. Write to the X standard and you won't 
have any such problems.

So? It is about choice. It is about standards. Motif is a standard. KDE/QT
is another (just not the same).

Inter-application communication is defined by the X protocol using the ICCM
standard. As far as I know they all do that.

> As an app programmer, one is always faced with the question, "which
> toolkit do I use?". And there is never an easy answer. I guess its high
> time for ppl to realize this. If any thing, this is definitely one thing
> thats slowing down the acceptance of Linux as a Desktop OS.

There is always an easy answer. Use the one approprate to the problem.

Of course you must know the problem, and you must know the tools you have
available. without that you better start learning.

One of the BEST things about X is that it is platform independant. This
gives me the ability to cut and paste from a QT application (kmail) into
a Motif terminal window, or even into an Xaw based xterm (or into TGIF, a
diagraming tool). I can even cut and paste from Mozilla without serious
problems.

Each application may be running on a completely different system.

You really need to go an learn some X programming.
