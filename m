Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbTAOOLC>; Wed, 15 Jan 2003 09:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTAOOLC>; Wed, 15 Jan 2003 09:11:02 -0500
Received: from khms.westfalen.de ([62.153.201.243]:22706 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S266425AbTAOOLB>; Wed, 15 Jan 2003 09:11:01 -0500
Date: 14 Jan 2003 22:46:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8dqiqC6mw-B@khms.westfalen.de>
In-Reply-To: <20030113134017$1d68@gated-at.bofh.it>
Subject: Re: why the new config process is a *big* step backwards
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20030113134017$1d68@gated-at.bofh.it>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rpjday@mindspring.com (Robert P. J. Day)  wrote on 13.01.03 in <20030113134017$1d68@gated-at.bofh.it>:

>   (apologies to those who are thoroughly sick of this topic, but
> i'm now firmly convinced that i don't much care for the new
> config process, and i'm curious as to whether it's just me.
> Answer: probably.)

Probably.

>   IMHO, the new config process (and i'll restrict myself to talking
> about the graphical "make xconfig" process here) not only doesn't

Hmm. The old xconfig was so unusable I haven't used anything but  
menuconfig for years ...
>
>   first, the hierarchical structure of the options in the left
> window (i'm going to make up names and call these the "menu window",
> "option window" and "help window") is non-intuitive, in that the
> top-level selection will bring up a set of selectable options,
> while submenus will *also* bring up options.
>
>   example:  Power management options.  if i select that menu
> option explicitly, i get options including APM in the option
> window.  but if i expand that option, i can select the submenu
> "ACPI Support", for further options.  this is confusing --
> it's analogous to a directory having files both directly inside
> it *and* within a sub-structure.
>
>   this is inconsistent with other common things people are
> familiar with -- in the pine mailer, for example, you can't
> use a folder both for storing files *and* for having subfolders.
> and think about bookmarks in a browser (a model i wish the new
> config process had followed).

Strange. Filesystems (which everyone should be familiar with) certainly do  
this, and so does (for example) Pegasus Mail with IMAP folders ...

I think Pine and bookmarks are faulty here. (Especially as in the current  
Mozilla, you *can* have folders-as-bookmarks but you can't easily switch  
from one behaviour to the other, plus Mozilla itself sometimes gets  
confused. Also, Open File insists on files even though Mozilla can handle  
local directories just fine ...)

>   the current design is messy since it suggests that some
> options belong strictly to the top level, while others belong
> to more specialized sub levels.

Well, that's certainly how it always was with menuconfig.

MfG Kai
