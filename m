Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTI3VwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbTI3VwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:52:05 -0400
Received: from aneto.able.es ([212.97.163.22]:61913 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261780AbTI3VwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:52:00 -0400
Date: Tue, 30 Sep 2003 23:51:57 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Krishna Akella <akellak@onid.orst.edu>
Cc: Paul Jakma <paul@clubi.ie>, kartikey bhatt <kartik_me@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
Message-ID: <20030930215157.GA4423@werewolf.able.es>
References: <Pine.LNX.4.44.0309301209590.19804-100000@shell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0309301209590.19804-100000@shell> (from akellak@onid.orst.edu on Tue, Sep 30, 2003 at 21:30:13 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.30, Krishna Akella wrote:
> Definitely, having the kernel support the GUI features is bad idea IMHO.
> but, What X lacks is a _standard_ toolkit, _complete_ widgetset for developers.
> We have
> acrobat using Motif distributed along with the reader, xfig "needing"
> preinstalled Motif, Xaw using Athena, Gnome apps using gtk, KDE apps using
> QT... and so on. Moreover, there is no standard interface for
> communication between these apps using myriad toolkits. And all of this is
> a duplication of effort that can be totally avoided.
> 
> As an app programmer, one is always faced with the question, "which
> toolkit do I use?". And there is never an easy answer. I guess its high
> time for ppl to realize this. If any thing, this is definitely one thing
> thats slowing down the acceptance of Linux as a Desktop OS.
> 

You can even choose a toolkit that goes beyond Linux:

http://www.gimp.org/~tml/gimp/win32/downloads.html
http://wwws.sun.com/software/star/gnome/
http://www.software.hp.com/products/GNOME/

And the same happens with Qt, I suppose.
Nowadays motif is used just for portability between Linux and other systems,
like IRIX or HPUX,
but it looks like the 'other' are moving to Gnome or KDE. So in a few years acrobat
will use gtk or qt, many oldies like xfig will be superceded by new apps,
and you real standards will be GTK and Qt.

And about interoperability, take a look at:

http://freedesktop.org/

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
