Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbRCFVLH>; Tue, 6 Mar 2001 16:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129498AbRCFVK5>; Tue, 6 Mar 2001 16:10:57 -0500
Received: from www.topmail.de ([212.255.16.226]:24974 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129496AbRCFVKs> convert rfc822-to-8bit;
	Tue, 6 Mar 2001 16:10:48 -0500
Message-ID: <026701c0a681$e93aa2e0$de00a8c0@homeip.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: "David Weinehall" <tao@acc.umu.se>,
        "Sean Hunter" <sean@dev.sportingbet.com>,
        "Laramie Leavitt" <laramie.leavitt@btinternet.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3AA4D92D.CDDB764D@ftel.co.uk> <JKEGJJAJPOLNIFPAEDHLEEDGCJAA.laramie.leavitt@btinternet.com> <20010306151242.D31649@dev.sportingbet.com> <20010306163711.A21941@khan.acc.umu.se>
Subject: Re: binfmt_script and ^M
Date: Tue, 6 Mar 2001 21:10:26 -0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "David Weinehall" <tao@acc.umu.se>
To: "Sean Hunter" <sean@dev.sportingbet.com>; "Laramie Leavitt" <laramie.leavitt@btinternet.com>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, 6. March 2001 15:37
Subject: Re: binfmt_script and ^M


> On Tue, Mar 06, 2001 at 03:12:42PM +0000, Sean Hunter wrote:
> > 
> > I propose
> > /proc/sys/kernel/im_too_lame_to_learn_how_to_use_the_most_basic_of_unix_tools_so_i_want_the_kernel_to_be_filled_with_crap_to_disguise_my_ineptitude
> > 
> > Any support?
> 
> <sarcasm>
> Hey, let's go even further! Let's add support in all programs for \r\n.

That is no sarcasm, it is ridiculous. CRLF line endings are ISO-IR-6 and
US-ASCII standard, and even UN*X systems used them when they had printers
(typewriters?) as output device, and no screens. With the Virtual Terminal,
Virtual Console stuff times may have changed but we have so many old stuff
in it... I won't remove them or didn't think of, but I remember you of:
 - lost+found
 - using ESC (or Alt???) as META for _shell commands_ which
   easily could be Ctrl-Left, Ctrl-Right, Ctrl-Del etc.
 - EMACS    :-((
 - ED/EX/VI :-(


The following does _not_ have to do with any US-ASCII or ISO_646.irv:1991
standards which IIRC are inherited by POSIX.
> And why not make all program use filenames that have an 8+3 char garbled
> equivalent where the last 3 are the indicators of the filetype. Oh, and
> let's do everything to make sure the user doesn't leave Gnome/KDE.
> And of course, let's add new features to all existing protocols and
> other standards to make them "superior" to other implementations.
> Oh, and of course, we must require an extra 64 MB of memory and
> 500 MB of diskspace for each release, and a 200MHz faster processor.
> And let us do all system settings through a registry.
> 
> OH! Let's change the name of the operating-system to something more
> catchy. Hmmm. Let's see. Windows maybe...
> </sarcasm>
> 
> 
> /David

I _do_ _not_ like Windoze either, but we live in a world
where we have to cope with it. I am even to code windoze
apps in order to support linux (no comment on this)...

-mirabilos


