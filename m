Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVFEDFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFEDFx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 23:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFEDFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 23:05:53 -0400
Received: from [12.161.0.3] ([12.161.0.3]:8719 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261424AbVFEDFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 23:05:40 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Sat, 4 Jun 2005 22:58:24 -0400
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
Message-ID: <20050605025823.GH32145@voodoo>
Mail-Followup-To: Greg Stark <gsstark@mit.edu>,
	Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	James Bottomley <James.Bottomley@steeleye.com>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com> <42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de> <42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com> <20050604191958.GA13111@havoc.gtf.org> <87k6l9k0aa.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6l9k0aa.fsf@stark.xeocode.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/05 10:25:17PM -0400, Greg Stark wrote:
> 
> So, uh, where do I get git? Where is your "git repository" and Linus' "git
> repository" and how do I set that up?
> 
> Or, at least, where do I find all this info?
> 
> 
> I take it it's not this:

No, but there is a cogito package in sid that includes the git tools.

> 
> Package: git
> Priority: optional
> Section: utils
> Installed-Size: 919
> Maintainer: Ian Beckwith <ianb@nessie.mcc.ac.uk>
> Architecture: i386
> Version: 4.3.20-7
> Depends: libc6 (>= 2.3.2.ds1-4), libncurses5 (>= 5.4-1), libreadline4 (>= 4.3-1)
> Filename: pool/main/g/git/git_4.3.20-7_i386.deb
> Size: 261822
> MD5sum: a708688e17259ed1e99d2828e1acb3f6
> Description: GNU Interactive Tools, a file browser/viewer and process viewer/killer
>  git (GNU Interactive Tools) is a set of interactive text-mode tools,
>  closely integrated with the shell.  It contains an extensible file
>  system browser, an ascii/hex file viewer, a process viewer/killer and
>  some other related utilities and shell scripts.  It can be used to
>  increase the speed and efficiency of most of the daily tasks such as
>  copying and moving files and directories, invoking editors,
>  compressing and uncompressing files, creating and expanding archives,
>  compiling programs, sending mail, etc.  It looks nice, has colors (if
>  the standard ANSI color sequences are supported) and is user-friendly.
>  .
>  One of the main advantages of Git is its flexibility.  It is not
>  limited to a given set of commands.  The configuration file can be
>  easily enhanced, allowing the user to add new commands or file
>  operations, depending on its needs or preferences.
> 
> 
> -- 
> greg

Jim.

