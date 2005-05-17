Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVEQScw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVEQScw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVEQScw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:32:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7083 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261889AbVEQScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:32:43 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: Jan Spitalnik <jan@spitalnik.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050517141307.GA7759@kestrel>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net>  <20050517141307.GA7759@kestrel>
Content-Type: text/plain; charset=iso-8859-2
Date: Tue, 17 May 2005 14:32:41 -0400
Message-Id: <1116354762.31830.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 16:13 +0200, Karel Kulhavy wrote:
> On Tue, May 17, 2005 at 12:08:03PM +0200, Jan Spitalnik wrote:
> > Dne út 17. kvìtna 2005 11:56 Karel Kulhavy napsal(a):
> > > Hello
> > >
> > > http://www.math.tu-berlin.de/~sbartels/alsa/driver/driver.html says
> > > "For example, there is currently ongoing work to allow mixing multiple
> > > inputs to the pcm devices."
> > >
> > 
> > Hi,
> > 
> > yes, ALSA can mix multiple inputs with its dmix plugin.
> > http://alsa.opensrc.org/index.php?page=DmixPlugin
> 
> Thanks for your reply.  I have proceeded according to this "Dmix Howto",
> however it doesn't work. I have proceeded successfully up to the command
> "aoss mpg123 some.mp3". When I run this, mp3 is played very fast, in
> about 1-2 seconds (normal pitch, but skipping very fast forward).
> 
> mpg123 Version 0.59s-r9 (2000/Oct/27)
> aoss doesn't have --version option
> alsaplayer 0.99.76
> 
> The document doesn't contain any contact where to send bugreports that
> the course described actually doesn't work.
> 
> Any other idea how to make Skype & XMMS run at the same time on Linux?

Yes, get the Skype developers to add proper ALSA support.  If Doom 3
could do it, so can they.

mpg123 is an open source application so there's no excuse for it not to
support ALSA in 2005.

Finally, these questions are all OT for LKML.  Try alsa-user at
lists.sf.net and alsa-devel at lists.sf.net.  Also there's a bug
reporting system, linked from http://www.alsa-project.org.

Lee

