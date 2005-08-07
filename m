Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752530AbVHGSlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbVHGSlk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbVHGSlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:41:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52122 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752530AbVHGSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:41:39 -0400
Subject: Re: [Alsa-devel] Re: any update on the pcmcia bug blocking Audigy2
	notebook sound card driver development
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Raymond Lai <raymond.kk.lai@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-audio-dev@music.columbia.edu,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <20050807104332.320aec48.akpm@osdl.org>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 14:41:35 -0400
Message-Id: <1123440095.12766.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 10:43 -0700, Andrew Morton wrote:
> Raymond Lai <raymond.kk.lai@gmail.com> wrote:
> >
> > Hi all,
> > 
> > I remember there's a kernel pcmcia bug preventing the development for 
> > the Audigy2 pcmcia notebook sound card driver. 
> > 
> > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > 
> > Is there any new updates on the situation? Has the bug been fixed? or
> > anyone working on it?
> > 
> 
> Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?

No, that was a known issue that is resolved in 2.6.13-rc*.  This is the
bug he's referring to:

http://lkml.org/lkml/2005/7/11/265

Looks like James never followed up, probably due to OLS.

Lee

