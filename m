Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284398AbRLIVCZ>; Sun, 9 Dec 2001 16:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284410AbRLIVCP>; Sun, 9 Dec 2001 16:02:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:270 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284398AbRLIVCB>; Sun, 9 Dec 2001 16:02:01 -0500
Date: Sun, 9 Dec 2001 17:45:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Rene Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <3C1378D6.A5BAB1FA@linux-m68k.org>
Message-ID: <Pine.LNX.4.21.0112091744430.24350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, Roman Zippel wrote:

> Richard Gooch wrote:
> 
> > Oh, the "tar kludge". That script has been obsolete for over a year
> > and a half. I should have removed it ages ago. I really should get
> > around to doing that one day.
> 
> You should have done this a year ago. Permission management with the
> "tar kludge" was a valid option so far and is currently in use. There
> was no warning period that this future would be obsolete.
> BTW from your devfsd-v1.3.20 release notes:
> 
> "NOTE: this release finally provides complete permissions management.
> Manually (i.e. non driver or devfsd) created inodes can now be
> restored when devfsd starts up. This requires v1.2 of the devfs core
> (available in 2.4.17-pre1) for best operation."
> 
> The tar solution only works until 2.4.16, the new devfsd provides this
> only with 2.4.17. I'll leave the final decision to Marcelo, whether he
> accepts this or not. I shut up now, may someone else explain the meaning
> of compatibility to you.

Roman, 

I haven't read the whole thread.

Could you please explain me what is the problem in detail? 

